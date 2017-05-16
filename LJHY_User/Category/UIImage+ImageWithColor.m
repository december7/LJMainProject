//mxclmade

#import "UIImage+ImageWithColor.h"

static NSCache *imageCache;

@implementation UIImage (WithColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[NSCache alloc] init];
    });
    
    UIImage *image = [imageCache objectForKey:color];
    if (image) {
        return image;
    }
    
    image = [self imageWithColor:color size:CGSizeMake(1,1)];
    [imageCache setObject:image forKey:color];
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}


+ (UIImage *)resizableImageWithColor:(UIColor *)color borderColor:(UIColor *)bdColor  cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = cornerRadius * 2 + 1;
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0.7;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [bdColor setStroke];

    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    [bdColor setStroke];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius) resizingMode:UIImageResizingModeStretch];

}


+ (UIImage *)resizableImageWithColor:(UIColor *)color width:(CGFloat)width lineWidth:(CGFloat)lineWidth borderColor:(UIColor *)bdColor  cornerRadius:(CGFloat)cornerRadius {
    
    if (width == 0)
        width = 2;
    

    if (width - cornerRadius * 2 <= 0)
    {
        width = cornerRadius * 2 + 1;
    }
    
    
    CGRect rect = CGRectMake(0, 0, width, width);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(cornerRadius, cornerRadius, width - cornerRadius * 2, width - cornerRadius * 2) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius , cornerRadius)];
    
//    if (lineWidth == 0)
//        lineWidth = 0.7;
    
    roundedRect.lineWidth = lineWidth;
    roundedRect.lineJoinStyle = kCGLineJoinRound;
    roundedRect.lineCapStyle = kCGLineCapRound;
    roundedRect.miterLimit = 1;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [bdColor setStroke];
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
        return [image resizableImageWithCapInsets:UIEdgeInsetsMake(width * 0.5, width * 0.5, width * 0.5, width * 0.5) resizingMode:UIImageResizingModeStretch];
}

@end
