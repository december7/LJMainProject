//
//  KZChoseAreaTool.h
//  zhuyuanbao
//
//  Created by Jason T on 15/11/4.
//  Copyright © 2015年 KangZhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZAreaM.h"

@class KZAreaM;
@interface KZChoseAreaTool : NSObject

+ (NSMutableArray *)choseAreaWithParentId:(NSString *)parentId;


//省
+ (NSMutableArray *)choseDistrctWithParentId:(NSString *)parentId;
//市
+ (NSMutableArray *)choseCityWithParentId:(NSString *)parentId;
//区
+ (NSMutableArray *)choseProvinceWithParentId:(NSString *)parentId;



//regionId 查询 返回
+ (KZAreaM *)choseAreaWithRegionId:(NSString *)regionId;


//传入（省，市，区 的id）数组， 返回一个不重复省市区
+ (NSString *)dealWithRepeatArea:(NSArray *)addAreaArray;



@end
