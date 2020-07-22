//
//  UITabBar+ljwcodeTabBarItem.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "UITabBar+ljwcodeTabBarItem.h"
#import <UIView+Frame.h>
#import "baseBadgeLabel.h"
//显示提示消息红点
@implementation UITabBar (ljwcodeTabBarItem)

-(UILabel *)badgeLabelWithStr:(NSString *)numStr
{
    baseBadgeLabel *label = [[baseBadgeLabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@",numStr];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:13.f];
    label.adjustsFontSizeToFitWidth = YES;
    [label sizeToFit];

    [self addSubview:label];
    
    return label;
}

-(void)showBadgeWithItemIndex:(NSInteger)index bageNumber:(NSInteger)number
{
    [self hideBadgeWithItemIndex:index];
    if(number > 99)
    {
        number = 99;
    }
    UILabel *badgeLabel = [self badgeLabelWithStr:[NSString stringWithFormat:@"%ld",(long)number]];
    badgeLabel.tag = 10000+index;
    CGRect tabFrame = self.frame;
    CGFloat percentX = (index+0.55)/self.items.count;
    CGFloat badgeX = ceil(tabFrame.size.width*percentX);
    CGFloat badgeY = ceil(tabFrame.size.width*0.1);
    badgeLabel.frame = CGRectMake(badgeX, badgeY, badgeLabel.frame.size.width, badgeLabel.frame.size.height);
    [self addSubview:badgeLabel];
}

-(void)hideBadgeWithItemIndex:(NSInteger)index
{
    for(UIView *view in self.subviews)
    {
        if(view.tag == 10000+index)//当点击跳到红点当前界面时，移除红点显示
        {
            [view removeFromSuperview];
        }
    }
}

@end
