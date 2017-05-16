//
//  ColumnViewController.m
//  Column
//
//  Created by fujin on 15/11/18.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import "ColumnViewController.h"
#import "CoclumnCollectionViewCell.h"
#import "ColumnReusableView.h"
#import "StudyTabModel.h"
#import "StudyTabDB.h"


#define SPACE 10.0
#define RGBA(r,g,b,a)      [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:a]
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
static NSString *cellIdentifier = @"CoclumnCollectionViewCell";
static NSString *headOne = @"ColumnReusableViewOne";
static NSString *headTwo = @"ColumnReusableViewTwo";

@interface ColumnViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DeleteDelegate>
/**
 *  collectionView
 */
@property (nonatomic, strong)UICollectionView *collectionView;
/**
 *  Whether sort
 */
@property (nonatomic, assign)BOOL isSort;
/**
 * Whether hidden the last
 */
@property (nonatomic, assign)BOOL lastIsHidden;
/**
 *  animation label（insert）
 */
@property (nonatomic, strong)UILabel *animationLabel;
/**
 *  attributes of all cells
 */
@property (nonatomic, strong)NSMutableArray *cellAttributesArray;


@property (nonatomic,strong)CoclumnCollectionViewCell * endCell;


@property (nonatomic,strong)NSArray * originlSelectedArray;

/**正在删除*/
@property (nonatomic,assign)BOOL deleting;
/**正在隐藏动画*/
@property (nonatomic,assign)BOOL animating;
/**正在移动*/
@property (nonatomic,assign)BOOL moving;


@end

@implementation ColumnViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.selectedArray = [[NSMutableArray alloc] init];
        self.optionalArray = [[NSMutableArray alloc] init];
        
        self.cellAttributesArray = [[NSMutableArray alloc] init];
        
        self.animationLabel = [[UILabel alloc] init];
        self.animationLabel.textAlignment = NSTextAlignmentCenter;
        self.animationLabel.font = [UIFont systemFontOfSize:15];
        self.animationLabel.numberOfLines = 1;
        self.animationLabel.adjustsFontSizeToFitWidth = YES;
        self.animationLabel.minimumScaleFactor = 0.1;
        self.animationLabel.textColor = RGBA(101, 101, 101, 1);
        self.animationLabel.layer.masksToBounds = YES;
        self.animationLabel.layer.borderColor = RGBA(211, 211, 211, 1).CGColor;
        self.animationLabel.layer.borderWidth = 0.45;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.deleting = NO;
    self.animating = NO;
    self.moving = NO;
    self.originlSelectedArray = [self.selectedArray  copy];
    
    [self setLeftItem];
    [self configCollection];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshData) name:@"SaveChannel" object:nil];
    
}
- (void)refreshData{
    
    
    StudyTabDB * studyTabDB = [StudyTabDB defaultDBManager];
    self.selectedArray = [studyTabDB getOrderedTabsWithTabType:nil];
    self.optionalArray = [studyTabDB getDisOrderedTabsWithTabType:nil];
    [self.collectionView reloadData];

}
-(void)setLeftItem{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIEdgeInsets inset   = UIEdgeInsetsMake(0, -15, 0, 0);
    leftButton.contentEdgeInsets = inset;
    leftButton.frame = CGRectMake(0, 0, 30, 30);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)back:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    BOOL state = NO;
    
    if ([self.originlSelectedArray isEqualToArray:self.selectedArray]) {
        
        if (self.callBack) {
            self.callBack(state);
        }
        
        return;
    }
    
    
    StudyTabDB * studyTabDB = [StudyTabDB defaultDBManager];
    [studyTabDB deleteStudyTab];
    for (StudyTabModel * studyM in self.selectedArray) {
        
        [studyTabDB saveStudyTabModel:studyM];
    }
    
    for (StudyTabModel * studyM in self.optionalArray) {
        
        [studyTabDB saveStudyTabModel:studyM];
    }

    
    if (self.callBack) {
        self.callBack(YES);
    }
}

#pragma mark ----------------- collectionInscance ---------------------
-(void)configCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CoclumnCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne];
    [self.collectionView registerClass:[ColumnReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo];
    [self.collectionView reloadData];
}
#pragma mark ----------------- sort ---------------------
-(void)sortItem:(UIPanGestureRecognizer *)pan{
    CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)pan.view;
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
    cell.contentLabel.hidden = NO;
    //开始  获取所有cell的attributes
    
    if (cellIndexPath.row > self.selectedArray.count -1 ) {
        
        return;
    }
    
    
    
    StudyTabModel * studyM  = [self.selectedArray objectAtIndex: cellIndexPath.row];
    
    //锁定的不能移动
    if ([studyM.locked isEqualToString:@"1"])  {

        return;
    }
    
    
    
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        if (self.deleting == YES ||self.animating == YES || self.moving == YES)
        {
            return;
        }
         //开始移动
        self.moving = YES;
        [self.cellAttributesArray removeAllObjects];
        for (NSInteger i = 0 ; i < self.selectedArray.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
        }
    }
    
    
    
    
    //移动手势，
    CGPoint point = [pan translationInView:self.collectionView];
    cell.center = CGPointMake(cell.center.x + point.x, cell.center.y + point.y);
    [pan setTranslation:CGPointMake(0, 0) inView:self.collectionView];

    

    
    //进行是否排序操作
    BOOL ischange = NO;
    for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
        CGRect rect = CGRectMake(attributes.center.x - 6, attributes.center.y - 6, 12, 12);
        if (CGRectContainsPoint(rect, CGPointMake(pan.view.center.x, pan.view.center.y)) & (cellIndexPath != attributes.indexPath)) {
            
             StudyTabModel * studyM  = [self.selectedArray objectAtIndex: attributes.indexPath.row ];
            
            //锁定的不能移动
            if ([studyM.locked isEqualToString:@"1"])  {
                continue;
                return;
             }
            
            
            //下面的不能移动到上面
            if (cellIndexPath.section != attributes.indexPath.section)
            
            {
                 continue;

            }
            //后面跟前面交换
            if (cellIndexPath.row > attributes.indexPath.row) {
                //交替操作0 1 2 3 变成（3<->2 3<->1 3<->0）
                for (NSInteger index = cellIndexPath.row; index > attributes.indexPath.row; index -- ) {
                    
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index - 1];
//                    StudyTabModel * studyM  = [self.selectedArray objectAtIndex:index-1];
//                    if (studyM.locked isEqualToString:@"1")  {
//
//                    }
                    studyM.order1 =[ NSString stringWithFormat:@"%zd",index -1 ];
                    
                }
                
            }
            //前面跟后面交换
            else{
                //交替操作0 1 2 3 变成（0<->1 0<->2 0<->3）
                for (NSInteger index = cellIndexPath.row; index < attributes.indexPath.row; index ++ ) {
                    [self.selectedArray exchangeObjectAtIndex:index withObjectAtIndex:index + 1];
                    
                    StudyTabModel * studyM  = [self.selectedArray objectAtIndex:index + 1];
                    studyM.order1 =[ NSString stringWithFormat:@"%zd",index + 1 ];
                }
                
            }
            
            int indx = 0;
            for (StudyTabModel * model in self.selectedArray) {
                model.order1 = [NSString stringWithFormat:@"%d",indx];
                indx++;
            }
        
            for (StudyTabModel * model in self.optionalArray) {
                model.order1 = @"0";
            }
            
            
            ischange = YES;
            [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
            
            //移动位置之后更新collectionView上对应cell的indexPath
                [self updateCellPath];
        }
        else{
            ischange = NO;
        }
    }
    
    //结束
    if (pan.state == UIGestureRecognizerStateEnded){
        
        
        self.moving = NO;
        if (ischange) {
            
        }
        else{
            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
    }
}

#pragma mark ----------------- press ---------------------

//- (void)longPressAction
//{
// 
//    
//}
#pragma mark ----------------- delete ---------------------
-(void)deleteItemWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row > self.selectedArray.count -1 ) {
        
        return;
    }
    

    if (self.deleting == YES ||self.animating == YES || self.moving == YES)
    {
        return;
    }
    
//    DebugLog(@"delete----indexpath.row =%zd",indexPath.row);
    
    //开始动画
    self.animating = YES;

    
    //数据整理
    [self.optionalArray insertObject:[self.selectedArray objectAtIndex:indexPath.row] atIndex:0];
    
    
      //刷新下一组第一个
    NSIndexPath * path = [NSIndexPath indexPathForItem:0 inSection:1];
    [self.collectionView insertItemsAtIndexPaths:@[path]];
    
//    变成已经订阅
    StudyTabModel * studyM  = [self.selectedArray objectAtIndex:indexPath.row];
    studyM.subscribed = @"0";
    
    
  
    
    //移除选中数据
    [self.selectedArray removeObjectAtIndex:indexPath.row];
    
    
    //刷新UI
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

     [self.collectionView reloadData];
    //删除之后更新collectionView上对应cell的indexPath
    
    [self updateCellPath];
 
    for (NSInteger i = 0; i < self.optionalArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:1];
        CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
    }
 
   
    //结束编辑
    self.animating = NO;
    
}

- (void)updateCellPath
{
    for (NSInteger i = 0; i < self.selectedArray.count; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:newIndexPath];
        cell.indexPath = newIndexPath;
//        DebugLog(@"--------i = %zd,newIndexPath.row = %zd,indexpath.row =%zd",i,newIndexPath.row,indexPath.row);
    }
    
}


#pragma mark ----------------- insert ---------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if  (![self showLoginVC])
    {
        return ;
    }
    if (indexPath.section == 1) {
    
        // 防止点击过快，造成数组越界
        if (indexPath.row > self.optionalArray.count -1 ) {
            
            return;
        }

        CoclumnCollectionViewCell *endCell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

        


        if (self.deleting == YES ||self.animating == YES || self.moving == YES)
        {
            return;
        }
        
        //开始动画
        self.deleting = YES;
        
        
         self.lastIsHidden = YES;
        
        //防止重复点击，造成最后一个已经释放，访问空数组崩溃现象
        if (indexPath.row > self.optionalArray.count -1 || self.optionalArray.count == 0 ) {

            return ;
        }
        

         StudyTabModel * studyM  = [self.optionalArray objectAtIndex:indexPath.row];
        
    


        endCell.contentLabel.hidden = YES;
        
        [self.selectedArray addObject:[self.optionalArray objectAtIndex:indexPath.row]];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        

        //移动开始的attributes
        UICollectionViewLayoutAttributes *startAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        
        self.animationLabel.frame = CGRectMake(startAttributes.frame.origin.x, startAttributes.frame.origin.y, startAttributes.frame.size.width , startAttributes.frame.size.height);
        self.animationLabel.layer.cornerRadius = CGRectGetHeight(self.animationLabel.bounds) * 0.0;
       
        //变成已订阅
        studyM.subscribed = @"1";
        self.animationLabel.text = studyM.name;
        [self.collectionView addSubview:self.animationLabel];
        NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:self.selectedArray.count-1 inSection:0];
        
        //移动终点的attributes
        UICollectionViewLayoutAttributes *endAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:toIndexPath];
        
        typeof(self) __weak weakSelf = self;
        //移动动画
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.animationLabel.center = endAttributes.center;
        } completion:^(BOOL finished) {
            
            //防止点击过快，造成数组越界
            if (indexPath.row > self.optionalArray.count -1 ) {
                
                return;
            }
        
            //这里再取一次，防止最后一个cell的contentLabel隐藏了
            CoclumnCollectionViewCell *currentCell = (CoclumnCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:toIndexPath];


            //结束编辑
            self.deleting = NO;

            
            currentCell.contentLabel.hidden = NO;
            weakSelf.lastIsHidden = NO;
            [weakSelf.animationLabel removeFromSuperview];
            
            [weakSelf.optionalArray removeObjectAtIndex:indexPath.row];
            [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];

        }];
        
    }
  
    
}

#pragma mark ----------------- item(样式) ---------------------
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_SIZE.width - (5*SPACE)) / 4.0, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(SPACE, SPACE, SPACE, SPACE);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return SPACE;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(SCREEN_SIZE.width, 40.0);
    }
    else{
        return CGSizeMake(SCREEN_SIZE.width, 30.0);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_SIZE.width, 0.0);
}

#pragma mark ----------------- collectionView(datasouce) ---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    if (self.isSort) {
//        return 1;
//    }
    
    
    int indx = 0;
    for (StudyTabModel * model in self.selectedArray) {
        model.order1 = [NSString stringWithFormat:@"%d",indx];
        indx++;
    }
    
    for (StudyTabModel * model in self.optionalArray) {
        model.order1 = @"0";
    }
    
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        

        return self.selectedArray.count;
    }
    else{
        return self.optionalArray.count;
    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ColumnReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headOne forIndexPath:indexPath];
            reusableView.buttonHidden = NO;
            reusableView.clickButton.selected = self.isSort;
            reusableView.backgroundColor = [UIColor whiteColor];
            typeof(self) __weak weakSelf = self;
            [reusableView clickWithBlock:^(ButtonState state) {
                
              if  (![self showLoginVC])
              {
                  
                  reusableView.clickButton.selected = !reusableView.clickButton.selected;

                  return ;
              }
                
                //排序删除
                if (state == StateSortDelete) {
                    weakSelf.isSort = YES;
                }
                //完成
                else{
                    weakSelf.isSort = NO;
                    
                    // 移除拖动手势，
                    if (weakSelf.cellAttributesArray.count) {
                        for (UICollectionViewLayoutAttributes *attributes in weakSelf.cellAttributesArray) {
                            CoclumnCollectionViewCell *cell = (CoclumnCollectionViewCell *)[weakSelf.collectionView cellForItemAtIndexPath:attributes.indexPath];
                            for (UIPanGestureRecognizer *pan in cell.gestureRecognizers) {
                                [cell removeGestureRecognizer:pan];
                            }
                        }
                    }
                }
                [weakSelf.collectionView reloadData];
            }];
            reusableView.titleLabel.text = @"我的频道";
            
        }else{
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headTwo forIndexPath:indexPath];
            reusableView.buttonHidden = YES;
//            reusableView.backgroundColor = RGBA(240, 240, 240, 1);
            reusableView.titleLabel.text = @"推荐频道";
        }
    }
    return (UICollectionReusableView *)reusableView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CoclumnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.contentLabel.hidden = NO;
//    cell.indexPath = indexPath;
//    cell.isAnimating = NO;
//    self.deleting = NO;
    
    if (indexPath.section == 0) {
        //--------将indexPath传递给cell-------
        [cell configCell:self.selectedArray withIndexPath:indexPath];
        
        StudyTabModel * studyM  = [self.selectedArray objectAtIndex:indexPath.row];
        //头条
        if ([studyM.locked isEqualToString:@"1"]) {
           cell.deleteButton.hidden = YES;
            cell.coverButton.hidden = YES;
        }else{
           cell.deleteDelegate = self;
           cell.deleteButton.hidden = !self.isSort;
             cell.coverButton.hidden = !self.isSort;
            if (self.isSort) {
                
                //给cell的label 添加移动手势
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(sortItem:)];
                [cell addGestureRecognizer:pan];
            }
            else{
                
            }
            //最后一位是否隐藏(为了动画效果)
            if (indexPath.row == self.selectedArray.count - 1) {
                cell.contentLabel.hidden = self.lastIsHidden;
            }
        }
        
//        DebugLog(@"+++++++++++++++++%@",studyM.order1);

        
    }else{
        //给cell的label 添加 边框,  --------将indexPath传递给cell-------
        [cell configCell:self.optionalArray withIndexPath:indexPath];
        cell.deleteButton.hidden = YES;
        cell.coverButton.hidden = YES;
    }
    
    return cell;
}
-(void)dealloc{}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
