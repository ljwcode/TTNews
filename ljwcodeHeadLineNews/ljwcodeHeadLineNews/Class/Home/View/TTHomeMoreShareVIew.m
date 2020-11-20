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

@end

@implementation TTHomeMoreShareVIew

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        for(int i = 0;i < self.titleArray.count;i++){
            UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [menuBtn setTitle:self.titleArray[i] forState:UIControlStateNormal];
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [menuBtn setImage:self.ImgArray[i] forState:UIControlStateNormal];
            menuBtn.titleLabel.font = [UIFont systemFontOfSize:10.f];
            menuBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            menuBtn.imageEdgeInsets = UIEdgeInsetsMake(-menuBtn.titleLabel.intrinsicContentSize.height/2, 0, 0, 0);
            menuBtn.titleEdgeInsets = UIEdgeInsetsMake(menuBtn.imageView.intrinsicContentSize.height, -menuBtn.imageView.intrinsicContentSize.width, 0, 0);
            [self.menuScrollView addSubview:menuBtn];
            
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace + i * (kMenuWidth + hSpace));
                make.top.mas_equalTo(2 * vSpace);
                make.width.mas_equalTo(kMenuWidth);
                make.height.mas_equalTo(kMenuHeight);
            }];
        }
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        [self addSubview:self.configureMenuScrollView];
        [self.configureMenuScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineView.mas_bottom).offset(0);
            make.height.mas_equalTo(CGRectGetHeight(self.frame) * 0.45);
        }];
        
        for(int i = 0;i < self.configureTitleArray.count;i++){
            UIButton *configureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [configureBtn setTitle:self.configureTitleArray[i] forState:UIControlStateNormal];
            [configureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [configureBtn setImage:[UIImage imageNamed:self.configureImgArray[i]] forState:UIControlStateNormal];
            configureBtn.titleLabel.font = [UIFont systemFontOfSize:10.f];
            configureBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [self.configureMenuScrollView addSubview:configureBtn];
            
            [configureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(hSpace + i * (kMenuWidth + hSpace));
                make.top.mas_equalTo(vSpace);
                make.width.mas_equalTo(kMenuWidth);
                make.height.mas_equalTo(kMenuHeight);
            }];
        }
        
    }
    return self;
}


#pragma mark ------ lazy load

-(UIScrollView *)menuScrollView{
    if(!_menuScrollView){
        _menuScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, CGRectGetHeight(self.frame) * 0.45)];
        _menuScrollView.delegate = self;
        _menuScrollView.contentSize = CGSizeMake(kMenuWidth * 9 + hSpace * 10, CGRectGetHeight(self.frame) * 0.45);
        _menuScrollView.showsVerticalScrollIndicator = NO;
        _menuScrollView.showsHorizontalScrollIndicator = NO;
        _menuScrollView.bounces = NO;
        _menuScrollView.bouncesZoom = NO;
    }
    return _menuScrollView;
}

-(NSArray *)titleArray{
    if(!_titleArray){
        _titleArray = [NSArray arrayWithObjects:@"转发到头条",@"截图分享",@"微信",@"朋友圈",@"QQ",@"QQ空间",@"私信",@"系统分享",@"复制链接", nil];
    }
    return _titleArray;
}

-(NSArray *)ImgArray{
    if(!_ImgArray){
        _ImgArray = [NSArray arrayWithObjects:@"weixin_newShare"@"pyq_newShare",@"qq_newShare",@"qqkj_newShare",@"mail_allshare",@"airdrop_newShare",@"copy_newShare", nil];
    }
    return _ImgArray;
}

-(UIScrollView *)configureMenuScrollView{
    if(!_configureMenuScrollView){
        _configureMenuScrollView = [[UIScrollView alloc]init];
        _configureMenuScrollView.delegate = self;
        _configureMenuScrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.frame) * 0.45);
        _configureMenuScrollView.showsVerticalScrollIndicator = NO;
        _configureMenuScrollView.showsHorizontalScrollIndicator = NO;
        _configureMenuScrollView.bounces = NO;
        _configureMenuScrollView.bouncesZoom = NO;
    }
    return _configureMenuScrollView;
}

-(NSArray *)configureTitleArray{
    if(!_configureTitleArray){
        _configureTitleArray = [NSArray arrayWithObjects:@"举报",@"收藏",@"夜间模式",@"字体设置", nil];
    }
    return _configureTitleArray;
}

-(NSArray *)configureImgArray{
    if(!_configureImgArray){
        _configureImgArray = [NSArray arrayWithObjects:@"ugc_icon_report",@"icon_details_collect",@"",@"", nil];
    }
    return _configureImgArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
