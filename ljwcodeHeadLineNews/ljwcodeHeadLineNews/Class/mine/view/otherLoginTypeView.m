//
//  otherLoginTypeView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/22.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "otherLoginTypeView.h"
#import <SDAutoLayout.h>

@interface otherLoginTypeView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong) NSArray *infoArray;

@property(nonatomic,strong) NSMutableArray *buttonArray;

@property(nonatomic,strong) NSMutableArray *pageViewArray;

@end

@implementation otherLoginTypeView
{
    NSInteger lineMaxNumber; //最大行数
    NSInteger singleMaxCount; //单行最大个数
}

- (void)dealloc{
    
    _scrollView = nil;
    _pageControl = nil;
    _infoArray = nil;
    _buttonArray = nil;
    _pageViewArray = nil;
}

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
                    InfoArray:(NSArray *)infoArray
                MaxLineNumber:(NSInteger)maxLineNumber
               MaxSingleCount:(NSInteger)maxSingleCount{
    if (self = [super initWithFrame:frame]) {
        _infoArray = infoArray;
        _buttonArray = [NSMutableArray array];
        _pageViewArray = [NSMutableArray array];
        lineMaxNumber = maxLineNumber;  //4
        singleMaxCount = maxSingleCount; //1
        [self configureDataSource];
        [self configureSubview];
        [self configAutoLayout];
    }
    
    return self;
}

#pragma mark - 初始化数据

- (void)configureDataSource{
    if (!_infoArray) {
        
        _infoArray = @[
            @{@"title" : @"密码登陆" , @"image" : @"login_other_pw" , @"highlightedImage" : @"login_other_pw" , @"type" : [NSNumber numberWithInteger:LoginTypeToPassWd]} ,
            
            @{@"title" : @"天翼登陆" , @"image" : @"login_other_ty" , @"highlightedImage" : @"login_other_ty" , @"type" : [NSNumber numberWithInteger:LoginTypeToTianyi]} ,
                        
            @{@"title" : @"QQ登陆" , @"image" : @"login_other_qq" , @"highlightedImage" : @"login_other_qq" , @"type" : [NSNumber numberWithInteger:LoginTypeToQQ]} ,
            
            @{@"title" : @"微信登陆" , @"image" : @"login_other_wx" , @"highlightedImage" : @"login_other_wx" , @"type" : [NSNumber numberWithInteger:LoginTypeToWeChat]}];
    }
    
    lineMaxNumber = lineMaxNumber > 0 ? lineMaxNumber : 2;
    singleMaxCount = singleMaxCount > 0 ? singleMaxCount : 3;
}

#pragma mark - 初始化子视图

- (void)configureSubview{
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_scrollView];
        
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:_pageControl];
    NSInteger index = 0;
    
    UIView *pageView = nil;
    
    for (NSDictionary *info in _infoArray) {
        
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            pageView = [[UIView alloc] init];
            
            [_scrollView addSubview:pageView];
            [_pageViewArray addObject:pageView];
        }
        //初始化按钮
        loginStyleButton *button = [[loginStyleButton alloc]init];
        [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(loginButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
        
        [pageView addSubview:button];
        
        [_buttonArray addObject:button];
        
        index++;
    }
    
    _pageControl.numberOfPages = _pageViewArray.count > 1 ? _pageViewArray.count : 0;
}

#pragma mark - 设置自动布局

- (void)configAutoLayout{
    
    NSInteger lineNumber = ceilf((double)_infoArray.count / singleMaxCount);
    NSInteger singleCount = ceilf((double)_infoArray.count / lineNumber);
    singleCount = singleCount >= _infoArray.count ? singleCount : singleMaxCount ;
    CGFloat buttonWidth = self.width / singleCount;
    
    CGFloat buttonHeight = 50;
    
    NSInteger index = 0;
    
    NSInteger currentPageCount = 0;
    
    UIView *pageView = nil;
    
    for (loginStyleButton *button in _buttonArray) {
        if (index % (lineMaxNumber * singleMaxCount) == 0) {
            pageView = _pageViewArray[currentPageCount];
            //布局页视图
            if (currentPageCount == 0) {
                pageView.sd_layout
                .leftSpaceToView(_scrollView , 0)
                .topSpaceToView(_scrollView , 0)
                .rightSpaceToView(_scrollView , 0)
                .heightIs((lineNumber > lineMaxNumber ? lineMaxNumber : lineNumber ) * buttonHeight);
            } else {
                pageView.sd_layout
                .leftSpaceToView(_pageViewArray[currentPageCount - 1] , 0)
                .topSpaceToView(_scrollView , 0)
                .widthRatioToView(_pageViewArray[currentPageCount - 1] , 1)
                .heightRatioToView(_pageViewArray[currentPageCount - 1] , 1);
            }
            currentPageCount ++;
        }
        if (index == 0) {
            button.sd_layout
            .leftSpaceToView(pageView , 0)
            .topSpaceToView(pageView , 0)
            .widthIs(buttonWidth)
            .heightIs(buttonHeight);
            
        } else {
            if (index % singleCount == 0) {
                if (index % (lineMaxNumber * singleMaxCount) == 0) {
                    button.sd_layout
                    .leftSpaceToView(pageView , 0)
                    .topSpaceToView(pageView , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                } else {
                    button.sd_layout
                    .leftSpaceToView(pageView , 0)
                    .topSpaceToView(_buttonArray[index - singleCount] , 0)
                    .widthIs(buttonWidth)
                    .heightIs(buttonHeight);
                }
            } else {
                
                button.sd_layout
                .leftSpaceToView(_buttonArray[index - 1] , 0)
                .topEqualToView(_buttonArray[index - 1])
                .widthIs(buttonWidth)
                .heightIs(buttonHeight);
            }
        }
        index ++;
    }
    
    _scrollView.sd_layout
    .topEqualToView(self)
    .leftSpaceToView(self, 0.0f)
    .rightSpaceToView(self , 0.0f)
    .heightRatioToView(_pageViewArray.lastObject , 1);
    
    [_scrollView setupAutoContentSizeWithRightView:_pageViewArray.lastObject rightMargin:0.0f];
    
    [_scrollView setupAutoContentSizeWithBottomView:_pageViewArray.lastObject bottomMargin:0.0f];
    _pageControl.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topSpaceToView(_scrollView , 5.0f)
    .heightIs(10.0f);
    
    [self setupAutoHeightWithBottomView:_pageControl bottomMargin:0.0f];
}

#pragma mark - 点击按钮跳转拉起第三方登陆

- (void)loginButtonHandle:(UIButton *)sender{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
