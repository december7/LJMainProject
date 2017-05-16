//
//  RichTextViewController.h
//  RichTextView
//
//  Created by     songguolin on 16/1/7.
//  Copyright © 2016年 innos-campus. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AriclePushlishParam,PlaceholderTextView;
@protocol RichTextViewControllerDelegate <NSObject>

@optional
-(void)uploadImageArray:(NSArray *)imageArr withCompletion:(NSString * (^)(NSArray * urlArray))completion;

@end




typedef NSArray *(^uploadCompelte)(void);
@interface RichTextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *subscribeBtn;

@property (weak,nonatomic) id<RichTextViewControllerDelegate>RTDelegate;

@property (weak, nonatomic) IBOutlet UILabel *subscribeLabel;
@property (weak, nonatomic) IBOutlet LimitTextField *titleLabel;

@property (weak, nonatomic) IBOutlet PlaceholderTextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *previewBtn;


//是否返回的是网页，是的话请实现 代理方法
@property (nonatomic,assign) BOOL feedbackHtml;

//这一种是返回
@property (nonatomic,copy) void (^finished)(id  content);

//初始化页面
//+(instancetype)ViewController;
+(instancetype)addController;


- (void)saveDraft;

- (void)publishClick;


- (NSArray * )getImageArray;
- (NSString *)getTextArray;
- (AriclePushlishParam * )getPlainAndImageArray;


//拼接文字
- (void)appendText:(NSString *)content;

// 拼接图片
- (void)appendImage:(UIImage * )image;

// 拼接图片(异步)
- (void)appendImageAsynchronously:(UIImage * )image AndUrlKey:(NSString * )url;


@end
