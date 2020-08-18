//
//  TTPageMenuItem.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPageMenuItem.h"
#import <Masonry/Masonry.h>

@interface TTPageMenuItem()

@end

@implementation TTPageMenuItem

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.trailing.mas_equalTo(self);
        }];
    }
    return self;
}

#pragma mark - lazy load

-(UILabel *)titleLabel{
    if(!_titleLabel){
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.f];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _titleLabel = label;
    }
    return _titleLabel;
}


#pragma mark - overwrite

-(void)menuItemNormalStyle{
    if(self.menuItemNormalStyleBlock){
        self.menuItemNormalStyleBlock();
    }
}

-(void)menuItemSelectedStyle{
    if(self.menuItemSelectedStyleBlock){
        self.menuItemSelectedStyleBlock();
    }
}

-(void)menuItemNormalStyleAnimation{
    if(self.menuItemNormalStyleAnimationBlock){
        self.menuItemNormalStyleAnimationBlock();
    }
}

-(void)menuItemSelectedStyleAnimation{
    if(self.menuItemSelectedStyleAnimationBlock){
        self.menuItemSelectedStyleAnimationBlock();
    }
}

-(void)setSelected:(BOOL)selected withAnimation:(BOOL)isAnimation{
    _itemSelected = selected;
    if(selected){
        [self menuItemSelectedStyle];
        if(isAnimation){
            [self menuItemSelectedStyleAnimationBlock];
        }
    }else{
        [self menuItemNormalStyleBlock];
        if(isAnimation){
            [self menuItemNormalStyleAnimationBlock];
        }
    }
}

@end
