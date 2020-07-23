//
//  buttonStyleTwo.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "buttonStyleTwo.h"
#import "ButtonViewTools.h"
#import <UIView+Frame.h>

@interface buttonStyleTwo()

@property(nonatomic,weak)UIImageView *imgView;

@property(nonatomic,weak)UILabel *label;

@property(nonatomic,strong)UIImage *img;

@property(nonatomic,copy)NSString *title;

@end

@implementation buttonStyleTwo

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self configureButtonWithTitle:_title Img:_img];
    }
    return self;
}

-(void)configrueTitle:(NSString *)title img:(UIImage *)img{
    _title = title;
    _img = img;
}

-(void)configureButtonWithTitle:(NSString *)title Img:(UIImage *)img{
    ButtonViewTools *viewTools = [[ButtonViewTools alloc]init];
    UIImageView *imgView = [viewTools packageImgView:img imgViewFrame:CGRectMake(0, 0, self.width, self.height/2) paraentView:self];
    _imgView = imgView;
    
    UILabel *label = [viewTools packageLabel:title paraentView:self labelFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame)+2, self.width, self.height/2-2) textColor:[UIColor lightGrayColor] fontSize:15.f];
    _label = label;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
