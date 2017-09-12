//
//  UITextField+Limit.m
//  yiliaotoutiao
//
//  Created by Jason T on 16/5/26.
//  Copyright © 2016年 YLTT. All rights reserved.
//


//@implementation LimitTextField
#import "LimitTextField.h"
@implementation LimitTextField



- (void)awakeFromNib
{
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification"object:self];
    

}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    
   
}


-(void)textFiledEditChanged:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _kMaxLength) {
                textField.text = [toBeString substringToIndex:_kMaxLength];
                
                if (self.inptutBlock)
                {
                    self.inptutBlock(textField.text);
                }
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > _kMaxLength) {
            textField.text = [toBeString substringToIndex:_kMaxLength];
            if (self.inptutBlock)
            {
                self.inptutBlock(textField.text);
            }
        }
    }
    
    if (self.inptutBlock)
    {
        self.inptutBlock(textField.text);
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:@"UITextFieldTextDidChangeNotification"
                                                 object:self];
}



@end