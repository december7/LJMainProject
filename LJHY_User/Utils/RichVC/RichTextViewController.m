//
//  ViewController.m
//  InputimageExample
//
//  Created by zorro on 15/3/6.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "RichTextViewController.h"

#import "PlaceholderTextView.h"

#import "ImageTextAttachment.h"
#import "NSAttributedString+RichText.h"
#import "PictureModel.h"
#import "NSAttributedString+html.h"
#import "AriclePushlishParam.h"
#import "UIScrollView+TPKeyboardAvoidingAdditions.h"

//Image default max size
#define IMAGE_MAX_SIZE ([UIScreen mainScreen].bounds.size.width-10)

#define ImageTag (@"[UIImageView]")
#define DefaultFont (16)
#define MaxLength (2000)

@interface RichTextViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIView *assaryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentConstraint;

@property (nonatomic,assign)CGFloat originHeight;

//设置
@property (nonatomic,assign) NSRange newRange;
@property (nonatomic,strong) NSString * newstr;
@property (nonatomic,assign) BOOL isBold;          //是否加粗
@property (nonatomic,strong) UIColor * fontColor;  //字体颜色
@property (nonatomic,assign) CGFloat  font;        //字体大小
@property (nonatomic,assign) NSUInteger location;  //纪录变化的起始位置
@property (nonatomic,strong) NSMutableAttributedString * locationStr;

@property (nonatomic,assign) CGFloat lineSapce;    //行间距
@property (nonatomic,assign) BOOL isDelete;        //是否是回删



@end

@implementation RichTextViewController
+(instancetype)addController
{
    RichTextViewController * ctrl=[[UIStoryboard storyboardWithName:@"RichText" bundle:nil]instantiateViewControllerWithIdentifier:@"RichTextViewController"];
    
    return ctrl;
}

- (CGFloat)font
{
    return DefaultFont;
}

-(void)CommomInit
{
    self.textView.delegate=self;
    [_textView becomeFirstResponder];
    [_textView scrollRectToVisible:CGRectMake(0, 0, ScreenWidth, _textView.contentSize.height) animated:YES];
    //显示链接，电话
    self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    self.font=DefaultFont;
    self.fontColor=[UIColor blackColor];
    self.location=0;
    self.isBold=NO;
    self.lineSapce=5;
    [self setInitLocation];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.textView.placeholder = @"请在此输入内容";
    self.originHeight =  ((445 - 50)/ 320.0)*ScreenWidth;
    
    //Init text font
    
    [self resetTextStyle];

    //Add keyboard notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onKeyboardNotification:) name:UIKeyboardWillShowNotification object:nil];
    
    
    UIBarButtonItem * backItem=[[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    self.navigationItem.leftBarButtonItem=backItem;
    
}

- (AriclePushlishParam * )getPlainAndImageArray
{
   return [_textView.attributedText getPlainAndImageArray];
}

- (NSArray *)getImageArray
{
    return  [_textView.attributedText getImgaeArray];
}

- (NSString *)getTextArray
{

    return  [_textView.attributedText getPlainString];

}

//返回保存数据
-(void)backClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetTextStyle {
    //After changing text selection, should reset style.
    [self CommomInit];
    NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    
    
    [_textView.textStorage removeAttribute:NSFontAttributeName range:wholeRange];
    [_textView.textStorage removeAttribute:NSForegroundColorAttributeName range:wholeRange];
    
    //字体颜色
    [_textView.textStorage addAttribute:NSForegroundColorAttributeName value:self.fontColor range:wholeRange];
    
    //字体加粗
    if (self.isBold) {
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.font] range:wholeRange];
    }
    //字体大小
    else
    {
        
        [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
    }
    
    
    
}
-(void)setInitLocation
{
    
    
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
   
    
}
-(void)setStyle
{
    
    
    //把最新的内容进行替换
    [self setInitLocation];
    
    
    if (self.isDelete) {
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = self.lineSapce;// 字体的行间距
    NSDictionary *attributes=nil;
     attributes = @{
                       NSFontAttributeName:[UIFont systemFontOfSize:self.font],
                       NSForegroundColorAttributeName:self.fontColor,
                       NSParagraphStyleAttributeName:paragraphStyle
                       };
        
    
    NSAttributedString * replaceStr=[[NSAttributedString alloc] initWithString:self.newstr attributes:attributes];
    
    self.newRange = NSMakeRange(self.newRange.location , self.newRange.length);
//    [self.locationStr replaceCharactersInRange:self.newRange withAttributedString:replaceStr];
   
    NSLog(@"--------self.locationStr----%@----self.newRange ---%lu",self.locationStr,(unsigned long)self.newRange.location);
    _textView.attributedText =self.locationStr;
    
    //这里需要把光标的位置重新设定
    self.textView.selectedRange=NSMakeRange(self.newRange.location+self.newRange.length, 0);
   
}
#pragma mark textViewDelegate
/**
 *  点击图片触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"%@", textAttachment);
    return NO;
}

/**
 *  点击链接，触发代理事件
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    [[UIApplication sharedApplication] openURL:URL];
    return YES;
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //    textview 改变字体的行间距
    
    
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
   
    if (range.length == 1)     // 回删
    {
       
        return YES;
    }
    else
    {
        
        // 超过长度限制
        if ([textView.text length] >= MaxLength+3)
        {
            
            return NO;
        }
    }

    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    NSInteger len=textView.attributedText.length-self.locationStr.length;

    self.textView.font = [UIFont systemFontOfSize: self.font];
    if (len>0) {
       
        self.isDelete=NO;
        
        if (self.textView.selectedRange.location > len)
        {
            self.newRange=NSMakeRange(self.textView.selectedRange.location-len, len);
        }else
        {
            self.newRange = NSMakeRange(len - self.textView.selectedRange.location, len);
        }
        self.newstr=[textView.text substringWithRange:self.newRange];
 
    }
    else
    {
        self.isDelete=YES;

    }
   
    
    bool isChinese;//判断当前输入法是否是中文
    
    NSArray *currentar = [UITextInputMode activeInputModes];
    UITextInputMode *textInputMode = [currentar firstObject];
    
    if ([[textInputMode primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
   
    NSString *str = [[ self.textView text] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        
        
        
        UITextRange *selectedRange = [ self.textView markedTextRange];
        
        
        //获取高亮部分
        UITextPosition *position = [ self.textView positionFromPosition:selectedRange.start offset:0];
      
       
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
//              NSLog(@"str=%@; 本次长度=%lu",str,(unsigned long)[str length]);
           
            [self setStyle];
            if ( str.length>=MaxLength) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength]];
            }
        }
        else
        {
//            NSLog(@"没有转化--%@",str);
            if ([str length]>=MaxLength+10) {
                NSString *strNew = [NSString stringWithString:str];
                [ self.textView setText:[strNew substringToIndex:MaxLength+10]];
            }
            
        }
    }else{
//        NSLog(@"英文");
      
        [self setStyle];
        if ([str length]>=MaxLength) {
            NSString *strNew = [NSString stringWithString:str];
            [ self.textView setText:[strNew substringToIndex:MaxLength]];
        }
    }
    
    
}
#pragma mark - Action



- (IBAction)resignClick:(UIButton *)sender
{
    [self.view endEditing:YES];
}

// 点击相机

- (IBAction)cameraAction:(id)sender {
    [self.view endEditing:YES];

    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        
    }
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:^{}];
    
}


//选择图片
- (IBAction)imageClick:(UIButton *)sender {
    [self.view endEditing:YES];
    

    [self selectedImage];
    
    
    
}
-(void)selectedImage
{
    
    NSUInteger sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
     [self appenReturn];
   
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //    // 保存图片至本地，方法见下文
    //    NSLog(@"img = %@",image);
    image = [self compressImage:image toMaxFileSize:150];
    
    
    
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    
    
    image=[imageTextAttachment scaleImage:image withSize:[self getMaxSize:image]];
    //Set tag and image
    imageTextAttachment.imageTag = ImageTag;
    imageTextAttachment.image =image;
    
    //Set image size
    imageTextAttachment.imageSize = image.size;
    
    //Insert image image
    [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                          atIndex:_textView.selectedRange.location];
    
    //Move selection location
    _textView.selectedRange = NSMakeRange(_textView.selectedRange.location, _textView.selectedRange.length);
    
    
    //设置字的设置
    [self setInitLocation];
    
    [self appenReturn];
    
    
    CGFloat offset = self.textView.contentSize.height - self.textView.bounds.size.height;
    if (offset > 0)
    {
        [self.textView setContentOffset:CGPointMake(0, offset) animated:YES];
    }
    
    
    
    
    [_textView becomeFirstResponder];
    
    
}


//拼接文字
- (void)appendText:(NSString *)content{
    
    
    NSAttributedString * newContent=[[NSAttributedString alloc]initWithString:content];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [att appendAttributedString:newContent];
    
    _textView.attributedText=att;
    
     NSRange wholeRange = NSMakeRange(0, _textView.textStorage.length);
    [_textView.textStorage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.font] range:wholeRange];
}


// 拼接图片(异步)
- (void)appendImageAsynchronously:(UIImage * )image AndUrlKey:(NSString * )url{

    [self.textView.attributedText appendImageAttachmentAsynchronously:image andUrlKey:url];
    
  
//    self.textView.attributedText.layoutBlock = ^ (id str){
//    
//        [self.textView layoutIfNeeded];
//    };
    
}

- (CGSize)getMaxSize:(UIImage *)image{

    CGFloat width = 0;
    CGFloat heigth = 0;
    if (image.size.width > ScreenWidth)
    {
        width = ScreenWidth;
        heigth = (ScreenWidth/image.size.width) * image.size.height;
    }else
    {
        width = image.size.width;
        heigth = image.size.height;
    }
    
    return CGSizeMake(width, heigth);
}


// 拼接图片(同步)
- (void)appendImage:(UIImage * )image{

    
    
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    
    
    
    image=[imageTextAttachment scaleImage:image withSize: [self getMaxSize:image]];
    //Set tag and image
    imageTextAttachment.imageTag = ImageTag;
    imageTextAttachment.image =image;
    
    imageTextAttachment.imageUrlKey = nil;
    //Set image size
//    imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, IMAGE_MAX_SIZE/2);

    imageTextAttachment.imageSize = image.size;
    
    //Insert image image
    [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]
                                          atIndex:_textView.selectedRange.location];
    
    //Move selection location
    _textView.selectedRange = NSMakeRange(_textView.selectedRange.location + 1, _textView.selectedRange.length);
    
    
    //设置字的设置
    [self setInitLocation];
    
    [self appenReturn];
}




// 压缩
- (UIImage *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.5f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    
    // 压缩到最小值
    while ([imageData length]/1024 > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    
    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return compressedImage;
}

-(void)appenReturn
{
    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [att appendAttributedString:returnStr];
    
    _textView.attributedText=att;
}
#pragma mark - Keyboard notification

// 键盘伸缩
- (void)onKeyboardNotification:(NSNotification *)notification {
    //Reset constraint constant by keyboard height
    if ([notification.name isEqualToString:UIKeyboardWillShowNotification]) {
        CGRect keyboardFrame = ((NSValue *) notification.userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
        _bottomConstraint.constant = keyboardFrame.size.height + 61;
        
        _textView.height = self.originHeight - keyboardFrame.size.height ;
    } else if ([notification.name isEqualToString:UIKeyboardWillHideNotification]) {
        _bottomConstraint.constant = -40;
        _textView.height = self.originHeight;
    }
    
    //Animate change
    [UIView animateWithDuration:0.1f animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
