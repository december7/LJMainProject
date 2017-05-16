////
////  KZChoseAreaTool.m
////  zhuyuanbao
////
////  Created by Jason T on 15/11/4.
////  Copyright © 2015年 KangZhi. All rights reserved.
////
//
//#import "KZChoseAreaTool.h"
//#import "FMDB.h"
//#import "KZAreaM.h"
//
//
//#define DBNAME      @"zyb.db"
//#define TABLENAME   @"app_city"
//#define REGION_ID   @"region_id"
//#define PARENT_ID   @"parent_id"
//#define REGION_NAME @"region_name"
//#define REGION_TYPE @"region_type"
//
//@implementation KZChoseAreaTool
//
//
//
//+ (NSString *)dealWithRepeatArea:(NSArray *)addAreaArray{
//    
//    
//    NSMutableString * address = [NSMutableString string];
//    
//    int idex =0;
//    KZAreaM * lastOneArea = nil;
//    for (KZAreaM * areaM in addAreaArray) {
//        
//        if([lastOneArea.region_name  isEqualToString:areaM.region_name] ){
//            
//            lastOneArea = areaM;
//            continue;
//        }else
//        {
//            
//            [address appendFormat:@" %@",areaM.region_name];
//        }
//        
//        lastOneArea = areaM;
//        
//    
//        idex++;
//    }
//    
//    
//    return address;
//}
//
//
//
//
//+ (NSMutableArray *)choseDistrctWithParentId:(NSString *)parentId
//{
//    
//   return  [self choseAreaWithParentId:parentId];
//
//}
//
//+ (NSMutableArray *)choseCityWithParentId:(NSString *)parentId
//{
//   return [self choseAreaWithParentId:parentId];
//
//}
//
//+ (NSMutableArray *)choseProvinceWithParentId:(NSString *)parentId
//{
//   return [self choseAreaWithParentId:parentId];
//}
//
//+ (KZAreaM *)choseAreaWithRegionId:(NSString *)regionId
//{
//   NSMutableArray * areaArray = [self choseAreaWithId:regionId andColumn:REGION_ID];
//    return areaArray.firstObject;
//}
//
//+ (NSMutableArray *)choseAreaWithParentId:(NSString *)parentId
//{
//   return  [self choseAreaWithId:parentId andColumn:PARENT_ID];
//}
//
//
//+ (NSMutableArray *)choseAreaWithId:(NSString *)Id andColumn:(NSString *)columnStr
//{
////    NSSearchPathForDirectoriesInDomains(NSHomeDirectory(), NSUserDomainMask, YES);
////    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
////    NSString *documents = [paths objectAtIndex:0];
////    NSString *  database_path = [documents stringByAppendingPathComponent:DBNAME];
//    
//     NSString *database_path = [[NSBundle mainBundle] pathForResource: DBNAME ofType:nil];
//
//    FMDatabase *db = [FMDatabase databaseWithPath:database_path];
//
//    NSMutableArray * areaArray = [NSMutableArray array];
//    //sql 语句
//    if ([db open]) {
//        
//        NSString * sql =[NSString stringWithFormat:@"SELECT * FROM app_city WHERE %@ = %@",columnStr,Id];
//        FMResultSet * rs = [db executeQuery:sql];
//        while ([rs next]) {
//            int regionId = [rs intForColumn:REGION_ID];
//            NSString * regionName = [rs stringForColumn:REGION_NAME];
//            NSString * parentId = [rs stringForColumn:PARENT_ID];
//            //NSLog(@"id = %d, name = %@, age = %@", regionId, regionName, parentId);
//            KZAreaM * areaM = [[KZAreaM alloc]init];
//            areaM.region_id = regionId;
//            areaM.parent_id = parentId;
//            areaM.region_name = regionName;
//            [areaArray addObject:areaM];
//        }
//        
//        [db close];
//    }
//
//    return areaArray;
//}
//
//
//@end
