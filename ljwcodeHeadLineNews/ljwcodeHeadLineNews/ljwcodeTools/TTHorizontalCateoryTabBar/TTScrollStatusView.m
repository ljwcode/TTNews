//
//  TTScrollStatusView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTScrollStatusView.h"
#import "TTStatusView.h"
#import <MJRefresh/MJRefresh.h>

@interface TTScrollStatusView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TTStatusViewDelegate>

@property(nonatomic,strong)TTStatusView *statusView;

@property(nonatomic,strong)UIScrollView *mainScrollView;

@property(nonatomic,strong)UITableView *curTable;

@property(nonatomic,assign)BOOL isRefresh;

@end

@implementation TTScrollStatusView

- (instancetype)initWithTitleArr:(NSArray *)titleArr
                            type:(ScrollTapType)type{
    if (self = [super init]){
        [self setupWithTitleArr:titleArr type:type];
    }
    return self;
}
-(instancetype)initWithTitleArr:(NSArray *)titleArr
                           type:(ScrollTapType)type
                 normalTabColor:(UIColor *)normalTabColor
                 selectTabColor:(UIColor *)selectTabColor
                      lineColor:(UIColor *)lineColor {
    
    if (self = [super init]) {
        [self setupWithTitleArr:titleArr
                           type:type
                 normalTabColor:normalTabColor
                 selectTabColor:selectTabColor
                      lineColor:lineColor];
    }
    return self;
}

#pragma mark - private function

- (void)setupWithTitleArr:(NSArray *)titleArr
                     type:(ScrollTapType)type {
    [self setupWithTitleArr:titleArr
                       type:type
             normalTabColor:setColorWithRed(154, 156, 156, 1)
             selectTabColor:setColorWithRed(0, 0, 0, 1)
                  lineColor:setColorWithRed(10, 193, 147, 1)];
}
-(void)setupWithTitleArr:(NSArray *)titleArr
                    type:(ScrollTapType)type
          normalTabColor:(UIColor *)normalTabColor
          selectTabColor:(UIColor *)selectTabColor
               lineColor:(UIColor *)lineColor {
    switch (type) {
        case ScrollTapTypeWithNavigation:
            self.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight - kTopHeight);
            break;
        case ScrollTapTypeWithNavigationAndTabbar:
            self.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight - kTopHeight - kTabBarHeight);
            break;
        case ScrollTapTypeWithNothing:
            self.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight);;
            break;
        default:
            self.frame = CGRectMake(0,0,kScreenWidth,kScreenHeight - kTopHeight);
            break;
    }
    
    [self setStatusViewWithTitleArr:titleArr
                        normalColor:normalTabColor
                      selectedColor:selectTabColor
                          lineColor:lineColor];
}

-(void)setStatusViewWithTitleArr:(NSArray *)titleArr
                     normalColor:(UIColor *)normalColor
                   selectedColor:(UIColor *)selectedColor
                       lineColor:(UIColor *)lineColor {
    float height = self.frame.size.height;
    float statusViewHeight = 45;
    _tableArr = [NSMutableArray array];
    [self.statusView setUpStatusButtonWithTitle:titleArr
                                    normalColor:normalColor
                                  selectedColor:selectedColor
                                      lineColor:lineColor];
    UIView *sessionLine = [[UIView alloc]initWithFrame:CGRectMake(0,statusViewHeight,kScreenWidth,5)];
    sessionLine.backgroundColor = setColorWithRed(242, 242, 242, 1);
    [self addSubview:sessionLine];

    statusViewHeight += sessionLine.frame.size.height;
    self.mainScrollView.frame = CGRectMake(0,statusViewHeight,kScreenWidth,height - statusViewHeight);
    self.mainScrollView.contentSize = CGSizeMake(kScreenWidth * titleArr.count, 0);
    float mainScrollH = height - statusViewHeight;
    for (NSInteger i = 0; i < titleArr.count; i++) {
        [self createTable:i height:mainScrollH];
    }
    if (_tableArr.count > 0) {
        _curTable = _tableArr[0];
    }
}

-(void)createTable:(NSInteger)index height:(float)height{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth * index, 0,kScreenWidth,height)];
    table.layer.borderColor = [UIColor blueColor].CGColor;
    table.layer.borderWidth = 5.f;
    table.delegate = self;
    table.dataSource = self;
    table.tag = index;
    table.tableFooterView = [[UIView alloc]init];
    table.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (self->_scrollStatusDelegate && [self->_scrollStatusDelegate respondsToSelector:@selector(refreshViewWithTag:isHeader:)]) {
            [self->_scrollStatusDelegate refreshViewWithTag:table.tag
                                                     isHeader:YES];
            [table.mj_header endRefreshing];
            self->_isRefresh = NO;
        }
    }];
    table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self->_isRefresh = YES;
        if (self->_scrollStatusDelegate && [self->_scrollStatusDelegate respondsToSelector:@selector(refreshViewWithTag:isHeader:)]) {
            self->_isRefresh = YES;
            [self->_scrollStatusDelegate refreshViewWithTag:table.tag
                                                     isHeader:NO];
        }
        [table.mj_footer endRefreshing];
        self->_isRefresh = NO;
    }];
    [self.tableArr addObject:table];
    [self.mainScrollView addSubview:table];
}

#pragma mark -- tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_scrollStatusDelegate && [_scrollStatusDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return  [_scrollStatusDelegate numberOfSectionsInTableView:tableView];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_scrollStatusDelegate && [_scrollStatusDelegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [_scrollStatusDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_scrollStatusDelegate && [_scrollStatusDelegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [_scrollStatusDelegate tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_scrollStatusDelegate && [_scrollStatusDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [_scrollStatusDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_scrollStatusDelegate && [_scrollStatusDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_scrollStatusDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark - scrollview Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITableView class]]) {
        if (_isRefresh == NO) {
            int scrollIndex = scrollView.contentOffset.x / kScreenWidth;
            _curTable = _tableArr[scrollIndex];
            [_statusView changeTag:scrollIndex];
        }
    }
}
- (void)statusViewSelectIndex:(NSInteger)index {
    [_mainScrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    _curTable = _tableArr[index];
}

#pragma mark - lazy load

- (UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]init];
        _mainScrollView.delegate = self;
        _mainScrollView.bounces  = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsVerticalScrollIndicator   = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    
        [self addSubview:_mainScrollView];
    }
    return _mainScrollView;
}
- (TTStatusView *)statusView {
    if (!_statusView) {
        _statusView = [[TTStatusView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth,45)];
        _statusView.delegate = self;
        _statusView.isScroll = YES;
        [self addSubview:_statusView];
    }
    return _statusView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
