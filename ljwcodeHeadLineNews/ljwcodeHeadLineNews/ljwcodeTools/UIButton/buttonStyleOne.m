//
//  buttonStyleOne.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "buttonStyleOne.h"
#import "ButtonViewTools.h"
#import <UIView+Frame.h>

@interface buttonStyleOne()

@property(nonatomic,strong)UIImage *img;

@property(nonatomic,copy)NSString *title;

@end

@implementation buttonStyleOne

-(void)layoutSubviews{
    [super layoutSubviews];
    [self configureButtonWithTitle:_title Img:_img];
}

-(void)configureTitle:(NSString *)title img:(UIImage *)img{
    _title = title;
    _img = img;
}

-(void)configureButtonWithTitle:(NSString *)title Img:(UIImage *)img{
    ButtonViewTools *viewTools = [[ButtonViewTools alloc]init];
    
    UILabel *titleLabel = [viewTools packageLabel:title paraentView:self labelFrame:CGRectMake(0, 0, self.width * 0.7, self.height) textColor:[UIColor blackColor] fontSize:12.f];
    UIImageView *imgView = [viewTools packageImgView:img imgViewFrame:CGRectMake(titleLabel.x+titleLabel.width + self.width * 0.1, self.center.y * 0.3, self.width * 0.2, self.height/2) paraentView:self];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
