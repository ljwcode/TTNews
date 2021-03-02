//
//  TTTabBar.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTTabBar.h"
#import "TTTabBarItem.h"

@interface TTTabBar()


@end

@implementation TTTabBar

-(void)TT_ClearView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma setter/getter

-(void)setTabBarItemArray:(NSMutableArray<TTTabBarItem *> *)tabBarItemArray{
    _tabBarItemArray = tabBarItemArray;
    [self TT_ClearView];
    for(int i=0;i<tabBarItemArray.count;i++){
        TTTabBarItem *item = tabBarItemArray[i];
        [self addSubview:item];
    }
    [self setCurrentIndex:0];
}

-(void)setCurrentIndex:(NSInteger)index{
    for(int i=0;i<self.tabBarItemArray.count;i++){
        TTTabBarItem *item = self.tabBarItemArray[i];
        [item tabBarItemSelected:i == index selectedIndex:index];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setupTabBarItems];
}

-(void)setupTabBarItems{
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;

    int count = (int)self.tabBarItemArray.count;
    CGFloat itemY = 0;
    CGFloat itemW = w / count;
    CGFloat itemH = h;

    for (int index = 0; index < count; index++) {
        TTTabBarItem *tabBarItem = self.tabBarItemArray[index];
        CGFloat itemX = index * itemW;
        tabBarItem.frame = CGRectMake(itemX, itemY, itemW, itemH);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
