//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView()<UITextViewDelegate>


@end
@implementation PlaceholderTextView

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-  (void)layoutSubviews
{
    [super layoutSubviews];
    
    //输入占位字符的时候重新调整label 的大小
    //占位字符和输入的大小一致。
    _PlaceholderLabel.font = self.placeholderFont;
    _PlaceholderLabel.textColor = self.placeholderColor;
    [_PlaceholderLabel sizeToFit];

    
    
    //如果有内容和占位字符，优先显示内容
    if(![self.text isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    else
    {
        _PlaceholderLabel.hidden=NO;
    }
    
    
}


- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length > 0)
    {
        _PlaceholderLabel.hidden=YES;
        
    }else
    {
        _PlaceholderLabel.hidden= NO;
        
    }
}

- (void)awakeFromNib {
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];

    float left=5,top=7,hegiht=20;
    if (self.placeholderColor == nil) {
    self.placeholderColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:205/255.0 alpha:1.0f];
    }
    _PlaceholderLabel=[[UILabel alloc] initWithFrame:CGRectMake(left, top
                                                               , self.frame.size.width, hegiht)];
    _PlaceholderLabel.numberOfLines = 0;
    _PlaceholderLabel.font = [UIFont systemFontOfSize:15];
    _PlaceholderLabel.textColor=self.placeholderColor;
//    [self addSubview:_PlaceholderLabel];
    [self insertSubview:_PlaceholderLabel atIndex:0];
    _PlaceholderLabel.text=self.placeholder;
    self.delegate = self;
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    else
    {
        _PlaceholderLabel.text=placeholder;
        _PlaceholderLabel.hidden=NO;

    }
    _placeholder=placeholder;
}



-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        _PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        _PlaceholderLabel.hidden=YES;
    }
    else{
        _PlaceholderLabel.hidden=NO;
    }
    
   
    
    
}


 -(void)textViewDidChange:(UITextView *)textView

{
    if (self.inptutBlock)
    {
        self.inptutBlock(textView.text);
    }
    
    if (self.maxCount >0) {
        
        if (textView.text.length > self.maxCount) {
            
            textView.text = [textView.text substringToIndex:_maxCount];
            
            NSString * str = [NSString stringWithFormat:@"字符个数不能大于%d",self.maxCount];
            UIAlertView *tipAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [tipAlert show];
        }
    }
    
}


//didEndInput

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_didEndInputBlock != nil) {
        _didEndInputBlock(textView.text );
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_PlaceholderLabel removeFromSuperview];

}

@end
