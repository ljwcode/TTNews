//
//  TTTabBarItem.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTTabBarItem.h"
#import <Masonry/Masonry.h>

@interface TTTabBarItem(){
    CGFloat itemWidth;
    UILabel *titleLabel;
    UIImage *TTnormalImg,*TTselectedImg;
    UIImageView *itemImage;
}


@end

@implementation TTTabBarItem

-(instancetype)init{
    if(self = [super init]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarViewHeight) name:TabBarViewHeight object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TTFontChangeHandle) name:TT_ALL_FONT_CHANGE object:nil];
    }
    return self;
}

-(void)CreateUI{
    itemWidth = kScreenWidth / 4;
    
    itemImage = [[UIImageView alloc] init];
    itemImage.image = [UIImage imageNamed:@""];
    [self addSubview:itemImage];
   
    [itemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(2);
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(itemWidth, 49/2));
    }];
    
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"  ";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_equalTo(itemImage.mas_bottom).offset(1);
    }];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    
}

-(instancetype)initWithItemTitle:(NSString *)ItemTitle normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg{
    if(self = [super init]){
        [self CreateUI];
        TTselectedImg = [UIImage imageNamed:selectedImg];
        TTnormalImg = [UIImage imageNamed: normalImg];
        titleLabel.text = ItemTitle;
        [itemImage setImage:TTselectedImg];
        [itemImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(49 * 2 / 3);
        }];

        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(itemImage.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self);
            make.bottom.mas_equalTo(TT_isIphoneX ? -34 - 2 : -2);
        }];
        titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    }
    return self;
}

-(void)tabBarItemSelected:(BOOL)selected selectedIndex:(NSInteger)index{
    if(selected && index == 0){
        titleLabel.hidden = NO;
        itemImage.hidden = NO;
    }else{
        titleLabel.hidden = !YES;
        itemImage.hidden = !YES;
    }
    if(selected){
        itemImage.image = TTselectedImg;
        titleLabel.textColor = TT_ColorWithRed(0.97, 0.35, 0.35, 1);
    }else{
        itemImage.image = TTnormalImg;
        titleLabel.textColor = TT_ColorWithRed(0.31, 0.31, 0.31, 1);
    }
}

#pragma mark ---- notification

-(void)tabBarViewHeight{
    itemWidth = kScreenWidth / 4;
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(itemImage.mas_bottom).offset(2);
        make.centerX.equalTo(self);
        make.bottom.mas_equalTo(TT_isIphoneX ? -34 - 2 : -2);
    }];
}

-(void)TTFontChangeHandle{
    titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    [self layoutIfNeeded];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
