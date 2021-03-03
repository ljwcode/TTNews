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
    UIImageView *TTitemImage;
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
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"  ";
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(itemWidth, TT_USERDEFAULT_float(TabBarViewHeight)/5-2));
    }];
    titleLabel.contentMode = UIViewContentModeScaleToFill;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    
    TTitemImage = [[UIImageView alloc] init];
    TTitemImage.image = [UIImage imageNamed:@""];
    TTitemImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:TTitemImage];
    [TTitemImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel.mas_top).offset(0);
        make.centerX.equalTo(self);
    }];
}

-(instancetype)initWithItemTitle:(NSString *)ItemTitle normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg{
    if(self = [super init]){
        [self CreateUI];
        TTselectedImg = [UIImage imageNamed:selectedImg];
        TTnormalImg = [UIImage imageNamed: normalImg];
        titleLabel.text = ItemTitle;
        [TTitemImage setImage:TTselectedImg];
        [TTitemImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.bottom.equalTo(titleLabel.mas_top).offset(-4);
            make.centerX.equalTo(self);
        }];
        titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    }
    return self;
}

-(void)tabBarItemSelected:(BOOL)selected selectedIndex:(NSInteger)index{
    if(selected && index == 0){
        titleLabel.hidden = NO;
        TTitemImage.hidden = NO;
    }else{
        titleLabel.hidden = !YES;
        TTitemImage.hidden = !YES;
    }
    if(selected){
        TTitemImage.image = TTselectedImg;
        titleLabel.textColor = [UIColor colorWithRed:0.97 green:0.35 blue:0.35 alpha:1];
    }else{
        TTitemImage.image = TTnormalImg;
        titleLabel.textColor = [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1];
    }
}

#pragma mark ---- notification

-(void)tabBarViewHeight{
    itemWidth = kScreenWidth / 4;
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-2);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(itemWidth, TT_USERDEFAULT_float(TabBarViewHeight)/2-2));
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
