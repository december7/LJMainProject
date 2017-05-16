//
//  NSAttributedString+RichText.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ LayoutBlock)(id str);


@class AriclePushlishParam;
@interface NSAttributedString (RichText)
/**
 *  获取带有图片标示的一个普通字符串
 *
 *  @return NSString
 */
- (NSString *)getPlainString;

//返回一个图片数组
-(NSArray *)getImgaeArray;

//返回数组，每个数组是一种属性和对应的内容
-(NSMutableArray *)getArrayWithAttributed;

//获取颜色值
- (NSString *)getHexStringByColor:(UIColor *)originColor;
//获取有 rgb，alpha的字典
- (NSDictionary *)getRGBDictionaryByColor:(UIColor *)originColor;

//返回图片和数组的按顺序交替字典
- (AriclePushlishParam *)getPlainAndImageArray;

// 异步插入图片
- (void)appendImageAttachmentAsynchronously:(UIImage *)image andUrlKey:(NSString *)url;

//@property (nonatomic,copy) LayoutBlock  layoutBlock; 

@end
