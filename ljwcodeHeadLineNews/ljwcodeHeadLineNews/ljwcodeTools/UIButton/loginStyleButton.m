//
//  loginStyleButton.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "loginStyleButton.h"
#import "ButtonViewTools.h"

@interface loginStyleButton()

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIImage *image;

@end

@implementation loginStyleButton

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //图片
    [self packageTapViewWithLeftImgName:_image rightTitle:_title btnFrama:self.frame];
    
}

- (void)configTitle:(NSString *)title Image:(UIImage *)image{
    
    _title = title;
    _image = image;
}

-(void)packageTapViewWithLeftImgName:(UIImage *)imageName rightTitle:(NSString *)title btnFrama:(CGRect)frame{
    ButtonViewTools *viewTools = [[ButtonViewTools alloc]init];
    UIImageView *msgImgView = [viewTools packageImgView:imageName imgViewFrame:CGRectMake(self.center.x*0.6, 0, CGRectGetWidth(self.frame)/5, CGRectGetHeight(self.frame)) paraentView:self];

    UILabel *sendMsgLoginLabel = [viewTools packageLabel:title paraentView:self labelFrame:CGRectMake(msgImgView.frame.origin.x + CGRectGetWidth(msgImgView.frame), msgImgView.frame.origin.y, CGRectGetWidth(msgImgView.frame), CGRectGetHeight(msgImgView.frame)) textColor:[UIColor colorWithRed:120/255.0 green:153/255.0 blue:188/255.0 alpha:1] fontSize:(13.f)];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
