//
//  TTTabBarView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTTabBarView.h"
#import "TTItemButton.h"
#import "TT_tabBarModel.h"

@interface TTTabBarView()

@property(nonatomic,assign)NSInteger currentItem;

@end

@implementation TTTabBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.currentItem = 1000;
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TTFontChangeHandle) name:TT_ALL_FONT_CHANGE object:nil];
    }
    return self;
}

-(void)TT_itemButton:(NSInteger)itemCount itemBlock:(TTItemButtonBlock)itemBlock withDataArray:(NSArray *)dataArray{
    CGFloat itemW = kScreenWidth / itemCount;
    CGFloat w = itemW / 2.0 - itemW / 2.0;
    for(int i = 0;i < itemCount;i++){
        TTItemButton *itemBtn = [TTItemButton buttonWithType:UIButtonTypeCustom];
        itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [itemBtn setTag:100 + i];
        TT_tabBarModel *model = dataArray[i];
        [itemBtn setTitle:model.titleName forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:model.normalImg] forState:UIControlStateNormal];
        [itemBtn setImage:[UIImage imageNamed:model.selectedImg] forState:UIControlStateSelected];
        [itemBtn setFrame:CGRectMake(w +itemW *i, 0, itemW, CGRectGetHeight(self.frame))];
        itemBtn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
        [itemBtn addTarget:self action:@selector(selectedItemIndexHandle:) forControlEvents:UIControlEventTouchUpInside];
        itemBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:itemBtn];
    }
    self.block = itemBlock;
}

#pragma mark ----- 响应事件
-(void)selectedItemIndexHandle:(UIButton *)sender{
    if(self.currentItem != sender.tag){
        self.currentItem = sender.tag;
        self.block(sender.tag);
    }
    
}

#pragma mark ----- ChangeFont
-(void)TTFontChangeHandle{
    for(int i = 0;i < 4;i++){
        TTItemButton *itemBtn = (TTItemButton *)[self viewWithTag:100 + i];
        itemBtn.titleLabel.font = TTFont(TT_USERDEFAULT_float(TT_DEFAULT_FONT));
    }
}

-(void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed{
    [self setHidden:hidesBottomBarWhenPushed];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
