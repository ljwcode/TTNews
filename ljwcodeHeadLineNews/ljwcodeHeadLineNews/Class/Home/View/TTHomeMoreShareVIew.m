//
//  TTHomeMoreShareVIew.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/20.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTHomeMoreShareVIew.h"

#define kMenuWidth 50

#define kMenuHeight 50

@interface TTHomeMoreShareVIew()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *menuScrollView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *ImgArray;

@property(nonatomic,strong)UIScrollView *configureMenuScrollView;

@property(nonatomic,strong)NSArray *configureTitleArray;

@property(nonatomic,strong)NSArray *configureImgArray;

@property(nonatomic,strong)UIView *footerView;

@end

@implementation TTHomeMoreShareVIew

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.menuScrollView];
        
        for(int i = 0;i < self.titleArray.count;i++){
            UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            menuBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            menuBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [menuBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [menuBtn setImage:[UIImage imageNamed:self.ImgArray[i]] forState:UIControlStateNormal];
            
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(-menuBtn.titleLabel.intrinsicContentSize.height/2-20, 0, 0, 0);
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(menuBtn.imageView.intrinsicContentSize.height, -menuBtn.imageView.intrinsicContentSize.width, 0, 0);
            menuBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.menuScrollView addSubview:menuBtn];
            
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace + i * (kMenuWidth + hSpace));
                make.centerY.mas_equalTo(self.menuScrollView);
                make.width.mas_equalTo(kMenuWidth);
                make.height.mas_equalTo(kMenuHeight);
            }];
        }
    
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.menuScrollView.mas_bottom).offset(1);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        [self addSubview:self.configureMenuScrollView];
        
        for(int i = 0;i < self.configureTitleArray.count;i++){
            UIButton *configureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [configureBtn setTitle:self.configureTitleArray[i] forState:UIControlStateNormal];
            [configureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [configureBtn setImage:[UIImage imageNamed:self.configureImgArray[i]] forState:UIControlStateNormal];
            configureBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            configureBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            configureBtn.imageEdgeInsets = UIEdgeInsetsMake(-configureBtn.titleLabel.intrinsicContentSize.height, 0, 0, -configureBtn.titleLabel.intrinsicContentSize.width);
            
            configureBtn.titleEdgeInsets = UIEdgeInsetsMake(configureBtn.imageView.intrinsicContentSize.height, -configureBtn.imageView.intrinsicContentSize.width, 0, 0);
            configureBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.configureMenuScrollView addSubview:configureBtn];
            
            [configureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace + i * (kMenuWidth + hSpace * 2));
                make.centerY.mas_equalTo(self.configureMenuScrollView);
                make.width.mas_equalTo(kMenuWidth);
                make.height.mas_equalTo(kMenuHeight);
            }];
        }
        
        [self addSubview:self.footerView];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        cancelBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [cancelBtn addTarget:self action:@selector(cancelHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self.footerView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.footerView);
            make.centerY.mas_equalTo(self.footerView);
            make.width.height.mas_equalTo(50);
        }];
        
    }
    return self;
}


#pragma mark ------ lazy load

-(UIScrollView *)menuScrollView{
    if(!_menuScrollView){
        _menuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame) * 0.4)];
        _menuScrollView.backgroundColor = TT_ColorWithRed(248, 248, 248, 1);
        _menuScrollView.delegate = self;
        _menuScrollView.contentSize = CGSizeMake(kMenuWidth * 9 + hSpace * 10, CGRectGetHeight(self.frame) * 0.3);
        _menuScrollView.showsVerticalScrollIndicator = NO;
        _menuScrollView.showsHorizontalScrollIndicator = NO;
        _menuScrollView.bounces = NO;
        _menuScrollView.bouncesZoom = NO;

    }
    return _menuScrollView;
}

-(NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSArray arrayWithObjects:@"转发到头条",@"微信",@"朋友圈",@"QQ",@"QQ空间",@"私信",@"系统分享",@"复制链接", nil];
    }
    return _titleArray;
}

-(NSArray *)ImgArray{
    if(!_ImgArray){
        _ImgArray = [NSArray arrayWithObjects:@"avatar_toutiao",@"weixin_newShare",@"pyq_newShare",@"qq_newShare",@"qqkj_newShare",@"mail_allshare",@"airdrop_newShare",@"copy_newShare", nil];
    }
    return _ImgArray;
}

-(UIScrollView *)configureMenuScrollView{
    if(!_configureMenuScrollView){
        _configureMenuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.menuScrollView.frame)+2, kScreenWidth, CGRectGetHeight(self.menuScrollView.frame))];
        _configureMenuScrollView.backgroundColor = TT_ColorWithRed(248, 248, 248, 0.5);
        _configureMenuScrollView.delegate = self;
        _configureMenuScrollView.contentSize = CGSizeMake(self.configureImgArray.count * kMenuWidth , CGRectGetHeight(self.menuScrollView.frame));
        _configureMenuScrollView.showsVerticalScrollIndicator = NO;
        _configureMenuScrollView.showsHorizontalScrollIndicator = NO;
        _configureMenuScrollView.bounces = NO;
        _configureMenuScrollView.bouncesZoom = NO;

    }
    return _configureMenuScrollView;
}

-(UIView *)footerView{
    if(!_footerView){
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.configureMenuScrollView.frame)+1, kScreenWidth, CGRectGetHeight(self.frame) -  CGRectGetHeight(self.configureMenuScrollView.frame)*2)];
    }
    return _footerView;
}

-(NSArray *)configureTitleArray{
    if(!_configureTitleArray){
        _configureTitleArray = [NSArray arrayWithObjects:@"举报",@"收藏",@"夜间模式",@"字体设置", nil];
    }
    return _configureTitleArray;
}

-(NSArray *)configureImgArray{
    if(!_configureImgArray){
        _configureImgArray = [NSArray arrayWithObjects:@"ugc_icon_report",@"tab_collect",@"night",@"font-size-2", nil];
    }
    return _configureImgArray;
}

#pragma mark ---- 响应事件
-(void)cancelHandle:(UIButton *)sender{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
