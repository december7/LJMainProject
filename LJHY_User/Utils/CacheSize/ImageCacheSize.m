

//
//  ImageCacheSize.m
//  yiliaotoutiao
//
//  Created by Jason T on 2016/12/12.
//  Copyright © 2016年 YLTT. All rights reserved.
//

#import "ImageCacheSize.h"

@implementation ImageCacheSize


////获取缓存的大小
//
//NSUInteger intg = [[SDImageCache sharedImageCache] getSize];
////
//NSString * currentVolum = [NSString stringWithFormat:@"%@",[self fileSizeWithInterge:intg]];

//计算出大小
- (NSString *)fileSizeWithInterge:(NSInteger)size{
    // 1k = 1024, 1m = 1024k
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}
@end
