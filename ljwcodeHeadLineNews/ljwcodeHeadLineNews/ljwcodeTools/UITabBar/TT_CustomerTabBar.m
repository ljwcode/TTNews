//
//  TT_CustomerTabBar.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/9.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_CustomerTabBar.h"

@interface TT_CustomerTabBar()

@property(nonatomic,strong)UIButton *selectBtn;

@end

@implementation TT_CustomerTabBar

-(void)setItemArray:(NSArray *)itemArray{
    _itemArray = itemArray;
    NSInteger index = 0;
    for (UITabBarItem *tabBarItem in itemArray) {
        UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectBtn setImage:tabBarItem.image forState:UIControlStateNormal];
        [selectBtn setImage:tabBarItem.selectedImage forState:UIControlStateSelected];
        selectBtn.tag = index;
        ++index;
        [selectBtn addTarget:self action:@selector(selectedItemHandle:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectBtn];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.itemArray.count; i++) {
        UIButton *itemBtn = self.subviews[i];
        CGFloat width = self.frame.size.width / self.itemArray.count;
        CGFloat height = self.frame.size.height;
        itemBtn.frame = CGRectMake(i * width, 0, width, height);
        
    }
}

#pragma mark ---- 响应事件

-(void)selectedItemHandle:(UIButton *)sender{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
