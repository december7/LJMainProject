//
//  KZAreaVC.h
//  zhuyuanbao
//
//  Created by Jason T on 15/10/21.
//  Copyright © 2015年 KangZhi. All rights reserved.
//

//#import "KZBaseVC.h"
//#import "KZFileVC.h"


// 选择完毕
#define  kChoseAreaDoneNote  @"choseAreaDoneNote"

@interface KZAreaVC : UIViewController


/**
 *  要返回的控制器
 */
@property (nonatomic,strong)UIViewController * rootVC;
@property (nonatomic,copy)NSString * parentId;
@property (nonatomic,strong)NSMutableArray * addAreaArray;

@end
