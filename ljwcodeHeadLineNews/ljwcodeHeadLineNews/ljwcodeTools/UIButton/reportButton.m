//
//  reportButton.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/21.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "reportButton.h"
#import <Masonry/Masonry.h>
#import <UIView+Frame.h>

@implementation reportButton

-(instancetype)initWithBtnText:(NSString *)text BtnImgView:(NSString *)imgName{
    if(self = [super init]){
        UIButton *imgBtn = [[UIButton alloc]init];
        [imgBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        [self addSubview:imgBtn];
        [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self);
            make.height.mas_equalTo(self).offset(self.height/2);
        }];
        
        //text
        UIButton *textBtn = [[UIButton alloc]init];
        [textBtn setTitle:text forState:UIControlStateNormal];
        textBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self addSubview:textBtn];
        [textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(imgBtn.mas_bottom);
            make.bottom.mas_equalTo(self);
        }];
    }
    
    return self;
}

-(UIButton *)reportButton:(NSString *)text showImg:(NSString *)imgName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //img
    UIButton *imgBtn = [[UIButton alloc]init];
    [imgBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn addSubview:imgBtn];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(btn);
        make.height.mas_equalTo(btn).offset(btn.frame.size.height/2);
    }];
    
    //text
    UIButton *textBtn = [[UIButton alloc]init];
    [textBtn setTitle:text forState:UIControlStateNormal];
    [btn addSubview:textBtn];
    [textBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(btn);
        make.top.mas_equalTo(imgBtn.mas_bottom);
        make.bottom.mas_equalTo(btn);
    }];
    
    return btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
