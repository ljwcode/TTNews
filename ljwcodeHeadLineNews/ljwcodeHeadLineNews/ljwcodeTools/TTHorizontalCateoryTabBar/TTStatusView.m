//
//  TTStatusView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTStatusView.h"

@interface TTStatusView()

@property(nonatomic,strong)NSMutableArray *buttonArray;

@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation TTStatusView

- (void)setUpStatusButtonWithTitle:(NSArray *)titleArray
                       normalColor:(UIColor *)normalColor
                     selectedColor:(UIColor *)selectedColor
                         lineColor:(UIColor *)lineColor{
    NSInteger count = titleArray.count;
    float width = (self.frame.size.width / count) * 0.7;
    for (int i = 0; i < count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        [button setTitleColor:normalColor forState:UIControlStateNormal];
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
        button.frame = CGRectMake(hSpace * 3 + width * i,0,width/2,self.frame.size.height);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        self.currentIndex = 0;
        [self.lineView setFrame:CGRectMake(CGRectGetMinX(button.frame) + i * width, CGRectGetMaxY(button.frame) - 5, CGRectGetWidth(button.frame), 5)];
        [self.lineView setBackgroundColor:lineColor];
        
        if(button.tag == 0){
            button.selected = YES;
        }
        [self.buttonArray addObject:button];
    }
}

- (void)buttonTouchEvent:(UIButton *)button{
    if (button.tag == self.currentIndex) {
        return;
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(statusViewSelectIndex:)]) {
        
        [self.delegate statusViewSelectIndex:button.tag];
    }
    if(!_isScroll) {
        [self changeTag:button.tag];
    }
}
-(void)changeTag:(NSInteger)tag
{
    self.currentIndex = tag;
    UIButton *button = self.buttonArray[tag];
    button.selected = YES;
    for(int i = 0; i < self.buttonArray.count; i++) {
        if (i != self.currentIndex) {
            UIButton *button = self.buttonArray[i];
            button.selected = NO;
        }
    }

    if(self.lineView){
        CGRect frame = self.lineView.frame;
        UIButton *button = self.buttonArray[tag];
        float origin = button.frame.origin.x;
        frame.origin.x = origin;
        self.lineView.frame = frame;
        [UIView animateWithDuration:0.2 animations:^{
            
        }];
    }
}

#pragma mark - lazy load

- (NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
    }
    return _lineView;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
