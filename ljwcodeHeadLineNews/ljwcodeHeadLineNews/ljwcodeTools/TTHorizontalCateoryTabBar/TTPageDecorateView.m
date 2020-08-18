//
//  TTPageDecorateView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTPageDecorateView.h"
#import <Masonry/Masonry.h>

@interface TTPageDecorateView()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView *progressView;

@property(nonatomic,weak)UIView *decorateView;

@property(nonatomic,assign)NSInteger decorateCount;

@property(nonatomic,assign)CGSize decorateSize;

@property(nonatomic,assign)NSInteger decorateIndex;

@property(nonatomic,assign)CGFloat decoratePosition;

@property(nonatomic,weak)CADisplayLink *cadLink;

@property(nonatomic,assign)CGFloat gap;

@property(nonatomic,assign)CGFloat steep;

@property(nonatomic,assign)int sign;

@end

@implementation TTPageDecorateView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.bottom.trailing.mas_equalTo(self);
        }];
        [self.scrollView addSubview:self.progressView];
    }
    return self;
}

#pragma mark - layz load

-(UIScrollView *)scrollView{
    if(!_scrollView){
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.delegate = self;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIView *)progressView{
    if(!_progressView){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor clearColor];
        _progressView = view;
    }
    return _progressView;
}

-(UIView *)decorateView{
    if(!_decorateView){
        UIView *view = [[UIView alloc]init];
        _decorateView = view;
    }
    return _decorateView;
}

-(void)setDecorateView:(UIView *)decorateView withDecorateCount:(NSInteger)decorateCount withDecorateSize:(CGSize)decorateSize{
    if(self.decorateView){
        [self.decorateView removeFromSuperview];
    }
    self.decorateView = decorateView;
    self.decorateCount = decorateCount;
    self.decorateSize = decorateSize;
    
    CGSize contentSize = CGSizeZero;
    contentSize = CGSizeMake(decorateSize.width * decorateCount, decorateSize.height);
    self.scrollView.contentSize = contentSize;
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView.contentSize.width);
    }];
    [self.progressView addSubview:self.decorateView];
    [self.decorateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.mas_equalTo(self.progressView);
        make.width.mas_equalTo(decorateSize.width);
        make.height.mas_equalTo(decorateSize.height);
    }];
    
}

-(void)moveToIndex:(NSInteger)index withAnimation:(BOOL)animation{
    if (self.decorateIndex == index) {
        [self moveToPosition:self.decoratePosition];
    } else {
        self.gap = self.decorateSize.width * labs(index -  self.decorateIndex);
        self.sign = self.decorateIndex > index ? -1 : 1;
        self.steep = animation ? self.gap / 15 : self.gap;
        self.decorateIndex = index;
        if (self.cadLink) {
            [self.cadLink invalidate];
        }
        // 通过 CADisplayLink 来执行动画
        CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(progressChanged)];
        [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        self.cadLink = link;
    }
}

#pragma mark - private method

-(void)moveToPosition:(CGFloat)position{
    self.decoratePosition = position;
    [self.decorateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(position);
    }];
    [self layoutIfNeeded];
}

- (void)progressChanged {
    if (self.gap > 0.00001) {
        self.gap -= self.steep;
        if (self.gap < 0.0) {
            [self moveToPosition:self.decoratePosition + self.sign * self.steep];
            return;
        }
        [self moveToPosition:self.decoratePosition + self.sign * self.steep];
    } else {
        [self moveToPosition:self.decoratePosition];
        [self.cadLink invalidate];
        self.cadLink = nil;
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
