////
////  KZAreaVC.m
////  zhuyuanbao
////
////  Created by Jason T on 15/10/21.
////  Copyright © 2015年 KangZhi. All rights reserved.
////
//
//#import "KZAreaVC.h"
////#import "FMDB.h"
//#import "FMDatabaseAdditions.h"
//#import "KZAreaM.h"
//#import "KZChoseAreaTool.h"
//
//#define DBNAME      @"zyb.db"
//#define TABLENAME   @"app_city"
//
//#define REGION_ID   @"region_id"
//#define PARENT_ID   @"parent_id"
//#define REGION_NAME @"region_name"
//#define REGION_TYPE @"region_type"
//
//
//
//@interface KZAreaVC ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong)UITableView  *tableView;
////@property (nonatomic,strong) FMDatabase *db;
////@property (nonatomic,copy) NSString *database_path;
//@property (nonatomic,strong)NSMutableArray * provinceArray;
//@property (nonatomic,strong)NSMutableArray * areaArray;
//
//@end
//
//@implementation KZAreaVC
//
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    
//    self.title = @"地区";
//    self.tableView = ({
//        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), [UIScreen mainScreen].bounds.size.height)];
//        tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0  blue:241/255.0 alpha:1];
//        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 20, 0);
//        tableView.dataSource = self;
//        tableView.delegate = self;
//        tableView.rowHeight = 44;
//        [self.view addSubview:tableView];
//        tableView.tableFooterView = [[UIView alloc]init];
//        tableView;
//    });
//    self.tableView.separatorInset = UIEdgeInsetsZero;
////    if (iOS8) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
////    }
//    
//    
//    if (self.parentId) {
//        //第二次进来就选择上次传递过来的
//
//        self.areaArray = [KZChoseAreaTool choseAreaWithParentId:self.parentId];
//
//    }else
//    {
//        //一进来 就选择省
//
//        self.areaArray = [KZChoseAreaTool choseAreaWithParentId:@"1"];
//    
//    }
//    
//    
//    [self.tableView reloadData];
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(returnBack)];
//    
//    
//    
//}
//- (void)returnBack
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//
//    
//}
//
//
//#pragma  mark --dataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.areaArray.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    static  NSString * ID = @"area";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    KZAreaM * areaM = self.areaArray[indexPath.row];
//    cell.textLabel.text = areaM.region_name;
//    return cell;
//    
//}
//
//#pragma  mark --Delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    KZAreaM * areaM = self.areaArray[indexPath.row];
//    [self.addAreaArray addObject:areaM];
//    
//    NSMutableArray * nextGroup = [KZChoseAreaTool choseAreaWithParentId:[NSString stringWithFormat:@"%d",areaM.region_id]];
//   KZAreaVC * cityVC = [[KZAreaVC alloc]init];
//    cityVC.parentId = [NSString stringWithFormat:@"%d",areaM.region_id];
//
//    //没有下一级
//    if (nextGroup.count==0) {
//
////        UIViewController * VC = self.navigationController.viewControllers[1];
//        if (self.rootVC != nil) {
//            
//            [self.navigationController popToViewController:self.rootVC animated:YES];
//        }
//        
//        //选择完毕
//        [[NSNotificationCenter defaultCenter]postNotificationName:kChoseAreaDoneNote object:nil];
//    }else
//    {  //有下一级
//       
//        cityVC.addAreaArray = self.addAreaArray;
//        cityVC.rootVC = self.rootVC ;
//        [self.navigationController pushViewController:cityVC animated:YES];
// 
//        
//       
//    }
//    
////    if (self.navigationController.viewControllers.count<5) {
////        [self.navigationController jumpToController:cityVC];
////    }else
////    {
////        UIViewController * VC = self.navigationController.viewControllers[1];
////        [self.navigationController popToViewController:VC animated:YES];
////    }
//    
//    
//}
//
//
////代理方法：
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//        
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//        
//    }
//    
//}
//
//
//
//
//
//@end
