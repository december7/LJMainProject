//
//  UIView+font.m
//  yiliaotoutiao
//
//  Created by Jason T on 16/5/17.
//  Copyright © 2016年 YLTT. All rights reserved.
//

#import "UIView+font.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>


#define  kCustomeSize [UIFont systemFontOfSize:  [UIScreen mainScreen].bounds.size.width /400.0 * fontSize]

@implementation UIView (font)

@end



@implementation UIButton (myFont)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.titleLabel.font.pointSize;
        self.titleLabel.font = kCustomeSize;
    }
    return self;
}

@end

@implementation UILabel (myFont)

+ (void)load
{
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode
{
    [self myInitWithCoder:aDecode];
    if (self) {
        CGFloat fontSize = self.font.pointSize;
        self.font = kCustomeSize;
        
        
    }
    return self;
}


@end


//@implementation UIFont (myFont)
//
//+ (UIFont *)systemFontOfSize:(CGFloat)fontSize
//{
//
////    UIFont * font = [UIFont systemFontOfSize:  [UIScreen mainScreen].bounds.size.width /400.0 * fontSize];
//   return  [UIFont systemFontOfSize: [UIScreen mainScreen].bounds.size.width /400.0 * fontSize];
//    
//}
//
//@end