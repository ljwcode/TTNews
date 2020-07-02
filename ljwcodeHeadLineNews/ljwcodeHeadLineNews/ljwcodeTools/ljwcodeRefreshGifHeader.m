//
//  ljwcodeRefreshGifHeader.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeRefreshGifHeader.h"

@interface ljwcodeRefreshGifHeader()

@property(nonatomic,weak)UILabel *label;

@end

@implementation ljwcodeRefreshGifHeader

#pragma mark - 重新自定义下拉刷新控件
-(void)prepare{
  
    [super prepare];
    self.mj_w = 50;
    self.mj_h = 25;
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for(int i = 1;i < 16;i++){
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%d",i]];
        [imageArray addObject:image];
    }
    [self setImages:imageArray forState:MJRefreshStateIdle];
    [self setImages:imageArray forState:MJRefreshStatePulling];
    [self setImages:imageArray forState:MJRefreshStateRefreshing];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:20.f];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    self.label = label;
}

-(void)placeSubviews{
    [super placeSubviews];
    self.label.frame = CGRectMake(0, 0, self.mj_w, self.mj_h);
    self.label.center = CGPointMake(self.center.x, self.mj_h);
    self.gifView.frame = CGRectMake(self.label.center.x, self.label.frame.origin.y - self.mj_h/2, self.label.frame.size.width/2, self.label.frame.size.height/2);
}

-(void)setState:(MJRefreshState)state{
    switch(state){
        case MJRefreshStateIdle:
            self.label.text = @"下拉刷新";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"刷新推荐";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"松开刷新";
            break;
        case MJRefreshStateWillRefresh:
            
            break;
        case MJRefreshStateNoMoreData:
            
            break;
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
