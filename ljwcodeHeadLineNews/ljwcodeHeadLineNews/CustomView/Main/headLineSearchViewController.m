//
//  headLineSearchViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "headLineSearchViewController.h"
#import <UIView+Frame.h>
#import <Masonry.h>

@interface headLineSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak)UIView *headView;

@property(nonatomic,weak)UIView *hotSearchView;

@property(nonatomic,weak)UIView *searchHistoryView;

@property(nonatomic,strong)NSMutableArray *searchHistory;

@property(nonatomic,weak)UISearchBar *searchBar;

@property(nonatomic,weak)UITextField *searchTextfield;

@property(nonatomic,assign)CGFloat cancelBtnWidth;

@property(nonatomic,weak)UITableView *baseSearchTableView;

@property(nonatomic,strong)NSArray<NSString *> *hotSearchies;

@property(nonatomic,copy)didSearchBlock searchBlock;

@property(nonatomic,weak)UIButton *emptyButton;

@property(nonatomic,weak)UILabel *searchHistoryLabel;

@property(nonatomic,weak)UIView *searchHistoryTagContentView;


@property(nonatomic,copy)NSString *historySearchCachePath;

@property(nonatomic,weak)UIButton *cancelButton;

@property(nonatomic,strong)UIBarButtonItem *cancelBarButtonItem;

@property(nonatomic,weak)UILabel *hotSearchHeaderLabel;

@property(nonatomic,weak)UIView *hotSearchTagContentView;

@property(nonatomic,weak)UILabel *emptySearchHistoryLabel;

@property(nonatomic,copy)NSArray<UILabel *> *rankTextLabels;

@property(nonatomic,copy)NSArray<UILabel *> *rankTags;

@property(nonatomic,copy)NSArray<UIView *> *rankViews;

@property(nonatomic,assign)BOOL swapHotSeachWithSearchHistory;

@property(nonatomic,copy)NSString *hotSearchTitle;

@property(nonatomic,copy)NSString *hotHistorySearchTitle;

@property(nonatomic,assign)BOOL showSearchHistory;

@property(nonatomic,assign)BOOL showKeyboard;

@property(nonatomic,copy)NSArray<UILabel *>* hotSearchTag;

@property(nonatomic,strong)UIColor *searchBarBackgroundColor;

@property(nonatomic,assign)BOOL removeSpaceOnSearchString;

@property(nonatomic,assign)NSUInteger searchHistoryCount;

@property(nonatomic,strong)UIViewController *resultShowController;

@property(nonatomic,copy)NSArray<UILabel *> *searchHistoryTag;

@property(nonatomic,assign)BOOL showHotSearch;

@property(nonatomic,assign)UIDeviceOrientation currentOrientation;

@end

@implementation headLineSearchViewController

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

-(instancetype)init{
    if(self = [super init]){
        [self setup];
    }
    return self;
}

-(UIImage *)drawImageContext:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(self.currentOrientation != [UIDevice currentDevice].orientation){
        self.hotSearchies = self.hotSearchies;
        self.searchHistory = self.searchHistory;
        self.currentOrientation = [UIDevice currentDevice].orientation;
    }
    CGFloat adaptWidth = 0;
    UISearchBar *searchBar = self.searchBar;
    UITextField *searchTextfield = [self.searchBar valueForKey:@"searchField"];
    searchTextfield = self.searchTextfield;
    UIView *titleView = self.navigationItem.titleView;
    
    UIButton *cancelButton = self.navigationItem.rightBarButtonItem.customView;
    UIEdgeInsets cancelBtnEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets navigationBarLyaoutEdgeInsets = UIEdgeInsetsZero;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    if(@available(iOS 8.0,*)){
        cancelButton.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 0);
        cancelBtnEdgeInsets = cancelButton.layoutMargins;
        navigationBarLyaoutEdgeInsets = navigationBar.layoutMargins;
    }
    
    adaptWidth = adaptWidth + navigationBarLyaoutEdgeInsets.left + navigationBarLyaoutEdgeInsets.right;
    if(@available(iOS 11.0,*)){
        NSLayoutConstraint *leftLayoutConstaaint = [searchBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor];
        if(navigationBarLyaoutEdgeInsets.left > SEARCH_MARGIN){
            [leftLayoutConstaaint setConstant:0];
        }else{
            [leftLayoutConstaaint setConstant:10-navigationBarLyaoutEdgeInsets.left];
        }
        [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(SEARCH_MARGIN);
            make.top.mas_equalTo(SEARCH_MARGIN);
            make.height.mas_equalTo(self.view.width > self.view.height ? 44 : 28);
            make.width.mas_equalTo(self.view.width - SEARCH_MARGIN * 2 - adaptWidth - cancelButton.width);
        }];
        searchTextfield.frame = searchBar.bounds;
        searchTextfield.layer.cornerRadius = 16.f;
        cancelButton.width = self.cancelBtnWidth;
        
    }else{
        titleView.x = SEARCH_MARGIN * 1.5;
        titleView.y = self.view.width > self.view.height ? 4 : 7;
        titleView.height = self.view.width > self.view.height ? 24 : 30;
        titleView.width = self.view.width - titleView.x * 2 - 3 - self.cancelBtnWidth;
    }
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[self drawImageContext:[UIColor whiteColor]]  forBarMetrics:UIBarMetricsDefault];
    
    [self hideHistorySearch];
    if(self.cancelBtnWidth == 0){
        [self viewDidLayoutSubviews];
    }
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    self.navigationController.navigationBarHidden = NO;
    if(self.resultShowController.parentViewController == NULL){
        [self.searchBar becomeFirstResponder];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self hideHistorySearch];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

#pragma mark - 外部初始化调用方法
+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *> *)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder{
    headLineSearchViewController *searchVC = [[self alloc]init];
    searchVC.hotSearchies = hotSearchies;
    searchVC.searchBar.placeholder = placeHolder;
    return searchVC;
}

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *> *)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock{
    headLineSearchViewController *headLineSearchVC = [self searchViewControllerWithHotSearchies:hotSearchies searchControllerPlaceHolder:placeHolder];
    headLineSearchVC.searchBlock = [searchBlock copy];
    return headLineSearchVC;
}

#pragma mark - 视图懒加载
-(UITableView *)baseSearchTableView{
    if(!_baseSearchTableView){
        UITableView *baseTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        baseTableView.backgroundColor = [UIColor clearColor];
        baseTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if([baseTableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]){
            baseTableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        baseTableView.delegate = self;
        baseTableView.dataSource = self;
        [self.view addSubview:baseTableView];
        _baseSearchTableView = baseTableView;
        
    }
    return _baseSearchTableView;
}

-(UIButton *)emptyButton{
    if(!_emptyButton){
        UIButton *emptyButton = [[UIButton alloc]init];
        emptyButton.titleLabel.font = self.searchHistoryLabel.font;
        [emptyButton setTitle:@"清空" forState:UIControlStateNormal];
        [emptyButton setTitleColor:setColorWithRed(113, 113, 113, 1) forState:UIControlStateNormal];
        [emptyButton setImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
        emptyButton.width += SEARCH_MARGIN;
        emptyButton.height += SEARCH_MARGIN;
        emptyButton.centerY = self.searchHistoryLabel.centerY;
        emptyButton.x = self.searchHistoryView.width - emptyButton.width*3;
        emptyButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [emptyButton addTarget:self action:@selector(emptyButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
        [emptyButton sizeToFit];
        [self.searchHistoryView addSubview:emptyButton];
        _emptyButton = emptyButton;
    }
    return _emptyButton;
}

-(UIView *)searchHistoryView{
    if(!_searchHistoryView){
        UIView *searchHistoryView = [[UIView alloc]init];
        searchHistoryView.x = self.hotSearchView.x;
        searchHistoryView.y = self.hotSearchView.y;
        searchHistoryView.width = self.headView.width - searchHistoryView.x * 2;
        searchHistoryView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.headView addSubview:searchHistoryView];
        _searchHistoryView = searchHistoryView;
        
    }
    return _searchHistoryView;
}

-(UILabel *)searchHistoryLabel{
    if(!_searchHistoryLabel){
        UILabel *titleLabel = [self setUpTitleLabelText:@""];
        [self.searchHistoryView addSubview:titleLabel];
        _searchHistoryLabel = titleLabel;
    }
    return _searchHistoryLabel;
}

-(UIView *)searchHistoryTagContentView{
    if(!_searchHistoryTagContentView){
        UIView *searchHistoryTagContentView = [[UIView alloc]init];
        searchHistoryTagContentView.width = self.searchHistoryView.width;
        searchHistoryTagContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        searchHistoryTagContentView.y = CGRectGetMaxY(self.hotSearchTagContentView.frame) + SEARCH_MARGIN;
        [self.searchHistoryView addSubview:searchHistoryTagContentView];
        _searchHistoryTagContentView = searchHistoryTagContentView;
    }
    return _searchHistoryTagContentView;
}

-(NSMutableArray *)searchHistory{
    if(!_searchHistory){
        _searchHistory = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.historySearchCachePath]];
    }
    return _searchHistory;
}

-(void)setup{
    self.showSearchHistory = YES;
    self.showHotSearch = YES;
    self.removeSpaceOnSearchString = YES;
    self.historySearchCachePath = SEARCH_HISTORY_SEARCH_PATH;
    self.searchHistoryCount = 20;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.baseSearchTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationController.navigationBar.backIndicatorImage = nil;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelButton addTarget:self action:@selector(cancelButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton sizeToFit];
    
    cancelButton.width += SEARCH_MARGIN;
    self.cancelButton = cancelButton;
    self.cancelBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.layer.cornerRadius = 12.f;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    [titleView addSubview:searchBar];
    if (systemVersion >= 11.0) { // iOS 11
        [NSLayoutConstraint activateConstraints:@[
            [searchBar.topAnchor constraintEqualToAnchor:titleView.topAnchor],
            [searchBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor],
            [searchBar.rightAnchor constraintEqualToAnchor:titleView.rightAnchor],
            [searchBar.bottomAnchor constraintEqualToAnchor:titleView.bottomAnchor]
        ]];
    } else {
        searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    self.navigationItem.titleView = titleView;
    searchBar.layer.cornerRadius = 15.f;
    searchBar.placeholder = @"搜你想搜";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    for (UIView *subView in [[searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subView;
            textField.font = [UIFont systemFontOfSize:16];
            self.searchTextfield = textField;
            self.searchTextfield.layer.cornerRadius = 15.f;
            break;
        }
    }
    self.searchBar = searchBar;
#pragma mark -----------------------------------------------------------------------------
    UIView *headerView = [[UIView alloc] init];
    headerView.width = kCompareScreenWidth;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *hotSearchView = [[UIView alloc] init];
    hotSearchView.x = SEARCH_MARGIN * 1.5;
    hotSearchView.width = headerView.width - hotSearchView.x * 2;
    hotSearchView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UILabel *titleLabel = [self setUpTitleLabelText:@"猜你想搜"];
    self.hotSearchHeaderLabel = titleLabel;
    [hotSearchView addSubview:titleLabel];
    
    UIView *hotSearchTagsContentView = [[UIView alloc] init];
    hotSearchTagsContentView.width = hotSearchView.width;
    hotSearchTagsContentView.y = CGRectGetMaxY(titleLabel.frame) + SEARCH_MARGIN;
    hotSearchTagsContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [hotSearchView addSubview:hotSearchTagsContentView];
    [headerView addSubview:hotSearchView];
    self.hotSearchTagContentView = hotSearchTagsContentView;
    self.hotSearchView = hotSearchView;
    self.headView = headerView;
    self.baseSearchTableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] init];
    footerView.width = kCompareScreenWidth;
    UILabel *emptySearchHistoryLabel = [[UILabel alloc] init];
    emptySearchHistoryLabel.textColor = [UIColor darkGrayColor];
    emptySearchHistoryLabel.font = [UIFont systemFontOfSize:13];
    emptySearchHistoryLabel.userInteractionEnabled = YES;
    emptySearchHistoryLabel.text = @"清空历史搜索";
    emptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
    emptySearchHistoryLabel.height = 49;
    [emptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyButtonHandle:)]];
    emptySearchHistoryLabel.width = footerView.width;
    emptySearchHistoryLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.emptySearchHistoryLabel = emptySearchHistoryLabel;
    [footerView addSubview:emptySearchHistoryLabel];
    footerView.height = emptySearchHistoryLabel.height;
    self.baseSearchTableView.tableFooterView = footerView;
    
    self.hotSearchies = nil;
}

/*
 热门搜索列表样式
 */
- (void)setupHotSearchRankTags
{
    UIView *contentView = self.hotSearchTagContentView;
    [self.hotSearchTagContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *rankTextLabelsM = [NSMutableArray array];
    NSMutableArray *rankTagM = [NSMutableArray array];
    NSMutableArray *rankViewM = [NSMutableArray array];
    for (int i = 0; i < self.hotSearchies.count; i++) {
        UIView *rankView = [[UIView alloc] init]; //定义每一个热门搜索标签视图
        rankView.height = 40;
        rankView.width = (self.baseSearchTableView.width - SEARCH_MARGIN * 3) * 0.5;
        rankView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:rankView];
        
        UILabel *rankTag = [[UILabel alloc] init];//热门搜索列表排序标签
        rankTag.textAlignment = NSTextAlignmentCenter;
        rankTag.font = [UIFont systemFontOfSize:10];
        rankTag.layer.cornerRadius = 3;
        rankTag.clipsToBounds = YES;
        rankTag.text = [NSString stringWithFormat:@"%d", i + 1];
        [rankTag sizeToFit];
        rankTag.width = rankTag.height += SEARCH_MARGIN * 0.5;
        rankTag.y = (rankView.height - rankTag.height) * 0.5;
        [rankView addSubview:rankTag];
        [rankTagM addObject:rankTag];
        
        UILabel *rankTextLabel = [[UILabel alloc] init];//热门搜索词排序
        [rankTextLabel setTag:i+1];
        rankTextLabel.text = self.hotSearchies[i];
        rankTextLabel.userInteractionEnabled = YES;
        [rankTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        rankTextLabel.textAlignment = NSTextAlignmentLeft;
        rankTextLabel.backgroundColor = [UIColor clearColor];
        rankTextLabel.textColor = setColorWithRed(113, 113, 113, 1);
        rankTextLabel.font = [UIFont systemFontOfSize:14];
        rankTextLabel.x = CGRectGetMaxX(rankTag.frame) + SEARCH_MARGIN;
        rankTextLabel.width = (self.baseSearchTableView.width - SEARCH_MARGIN * 3) * 0.5 - rankTextLabel.x;
        rankTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        rankTextLabel.height = rankView.height;
        [rankTextLabelsM addObject:rankTextLabel];

        [rankView addSubview:rankTextLabel];
        
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        line.height = 0.5;
        line.alpha = 0.7;
        line.x = -kCompareScreenWidth * 0.5;
        line.y = rankView.height - 1;
        line.width = self.baseSearchTableView.width;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [rankView addSubview:line];
        [rankViewM addObject:rankView];
        
        switch (i) {
            case 0:
                rankTag.backgroundColor = setColorWithRed(241, 66, 48, 1);
                rankTag.textColor = [UIColor whiteColor];
                break;
            case 1:
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = setColorWithRed(255, 128, 0, 1);
                break;
            case 2:
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = setColorWithRed(255, 204, 1, 1);
                break;
            default:
                rankTag.backgroundColor = [UIColor lightGrayColor];
                rankTag.textColor = setColorWithRed(113, 113, 113, 1);
                break;
        }
    }
    self.rankTextLabels = rankTextLabelsM;
    self.rankTags = rankTagM;
    self.rankViews = rankViewM;
    
    for (int i = 0; i < self.rankViews.count; i++) {
        UIView *rankView = self.rankViews[i];
        rankView.x = (SEARCH_MARGIN + rankView.width) * (i % 2);
        rankView.y = rankView.height * (i / 2);
    }
    
    contentView.height = CGRectGetMaxY(self.rankViews.lastObject.frame);
    self.hotSearchView.height = CGRectGetMaxY(contentView.frame) + SEARCH_MARGIN * 2;
    self.baseSearchTableView.tableHeaderView.height = self.headView.height = MAX(CGRectGetMaxY(self.hotSearchView.frame), CGRectGetMaxY(self.searchHistoryView.frame));
    [self layoutDemand];
    [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
}

-(void)layoutDemand{
    if (self.swapHotSeachWithSearchHistory == NO) {
        self.hotSearchView.y = SEARCH_MARGIN * 2;
        self.searchHistoryView.y = self.hotSearchies.count > 0 && self.showHotSearch ? CGRectGetMaxY(self.hotSearchView.frame) : SEARCH_MARGIN * 1.5;
    } else { // swap popular search whith search history
        self.searchHistoryView.y = SEARCH_MARGIN * 1.5;
        self.hotSearchView.y = self.searchHistory.count > 0 && self.showSearchHistory ? CGRectGetMaxY(self.searchHistoryView.frame) : SEARCH_MARGIN * 2;
    }
}

-(UILabel *)setUpTitleLabelText:(NSString *)text{
    UILabel *label = [[UILabel alloc]init];
    [label setTag:1];
    label.text = text;
    label.textColor = setColorWithRed(113, 113, 113, 1);
    label.x = 0;
    label.y = 0;
    [label sizeToFit];
    label.font = [UIFont systemFontOfSize:13];
    return label;
}

-(UILabel *)setUpLabelWithTitle:(NSString *)title{
    UILabel *label = [[UILabel alloc]init];
    label.userInteractionEnabled = YES;
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = setColorWithRed(250, 250, 250, 1);
    label.clipsToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 3;
    [label sizeToFit];
    label.width += 20;
    label.height += 14;
    return label;
}

-(void)saveSearchCacheWithRefreshView{
    UISearchBar *searchBar = self.searchBar;
    [searchBar resignFirstResponder];
    NSString *searchText = searchBar.text;
    if(self.removeSpaceOnSearchString){
        searchText = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@" "];
    }
    if(self.showSearchHistory && searchText.length > 0){
//        [self.searchHistory removeAllObjects];
        [self.searchHistory insertObject:searchText atIndex:0];
        if(self.searchHistory.count > self.searchHistoryCount){
            [self.searchHistory removeLastObject];
        }
        [NSKeyedArchiver archiveRootObject:self.searchHistory toFile:self.historySearchCachePath];
    }
    [self handleResultShow];
}
/*
 跳转目标显示控制器
 */
-(void)handleResultShow{
    self.resultShowController.view.hidden = NO;
//    [self.navigationController pushViewController:self.resultShowController animated:YES];
}

#pragma mark - 事件响应

-(void)emptyButtonHandle:(UIButton *)sender{
    [self.searchHistory removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.searchHistory toFile:self.historySearchCachePath];
    if(self.swapHotSeachWithSearchHistory == YES){
        self.hotSearchies = self.hotSearchies;
    }
}

-(void)cancelButtonHandle:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyBoardDidShow:(NSNotification *)noti{
    
}

-(void)tagDidCLick:(UITapGestureRecognizer *)tap{
    UILabel *label = (UILabel *)tap.view;
    self.searchBar.text = label.text;
    [self searchBarSearchButtonClicked:self.searchBar];
//    [self.searchHistory addObject:self.searchBar.text];
    [self.baseSearchTableView reloadData];
    NSLog(@"searchHIstory = %@",self.searchHistory);
}

-(void)closeDidClick:(UIButton *)sender{
    UITableViewCell *cell = (UITableViewCell *)sender.superview;
    [self.searchHistory removeObject:cell.textLabel.text];
    [NSKeyedArchiver archiveRootObject:self.searchHistory toFile:self.historySearchCachePath];
    [self.baseSearchTableView reloadData];
}

#pragma mark - setter

-(void)setRankTextLabels:(NSArray<UILabel *> *)rankTextLabels{
    for(UILabel *label in rankTextLabels){
        [label setTag:1];
    }
    _rankTextLabels = rankTextLabels;
}

//交换流行搜索和历史搜索的位置
-(void)setSwapHotSeachWithSearchHistory:(BOOL)swapHotSeachWithSearchHistory{
    _swapHotSeachWithSearchHistory = swapHotSeachWithSearchHistory;
    self.hotSearchies = self.hotSearchies;
    self.searchHistory = self.searchHistory;
}

-(void)setHotSearchTitle:(NSString *)hotSearchTitle{
    _hotSearchTitle = [hotSearchTitle copy];
    self.hotSearchHeaderLabel.text = hotSearchTitle;
}

-(void)setHotHistorySearchTitle:(NSString *)hotHistorySearchTitle{
    _hotHistorySearchTitle = [hotHistorySearchTitle copy];
    self.searchHistoryLabel.text = hotHistorySearchTitle;
}

-(void)hideHistorySearch{
    if(!self.searchHistory.count){
        self.searchHistoryLabel.hidden = YES;
        self.searchHistoryTagContentView.hidden = YES;
        self.emptyButton.hidden = YES;
        self.searchHistoryView.hidden = YES;
    }
    self.searchHistoryLabel.hidden = NO;
    self.searchHistoryView.hidden = NO;
    self.emptyButton.hidden = NO;
    self.searchHistoryTagContentView.hidden = NO;
}

-(void)setHotSearchies:(NSArray<NSString *> *)hotSearchies{
    _hotSearchies = hotSearchies;
    if(hotSearchies.count == 0 || !self.showHotSearch){
        self.hotSearchHeaderLabel.hidden = YES;
        self.searchHistoryTagContentView.hidden = YES;
        UIView *tableViewHeader = self.baseSearchTableView.tableHeaderView;
        tableViewHeader.height = SEARCH_MARGIN * 1.5;
        [self.baseSearchTableView setTableHeaderView:tableViewHeader];
        return;
    }
    self.hotSearchHeaderLabel.hidden = NO;
    self.hotSearchTagContentView.hidden = NO;
    self.baseSearchTableView.tableHeaderView.hidden = NO;
    [self setupHotSearchRankTags];
    [self hideHistorySearch];
}

-(void)setShowSearchHistory:(BOOL)showSearchHistory{
    _showSearchHistory = showSearchHistory;
    [self setHotSearchies:self.hotSearchies];
    [self hideHistorySearch];
}

-(void)setCancelBarButtonItem:(UIBarButtonItem *)cancelBarButtonItem{
    _cancelBarButtonItem = cancelBarButtonItem;
    self.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

-(void)setCancelButton:(UIButton *)cancelButton{
    _cancelButton = cancelButton;
    self.navigationItem.rightBarButtonItem.customView = cancelButton;
}

-(void)setHotSearchTag:(NSArray<UILabel *> *)hotSearchTag{
    for(UILabel *label in hotSearchTag){
        [label setTag:1];
    }
    _hotSearchTag = hotSearchTag;
}

-(void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor{
    _searchBarBackgroundColor = searchBarBackgroundColor;
    self.searchTextfield.backgroundColor = searchBarBackgroundColor;
}

-(void)setHotSearchStyle:(CGFloat)hotSearchStyle{
    _hotSearchStyle = hotSearchStyle;
}

-(void)setShowHotSearch:(BOOL)showHotSearch{
    _showHotSearch = showHotSearch;
    [self setHotSearchies:self.hotSearchies];
    [self hideHistorySearch];
}

-(void)setHistorySearchCachePath:(NSString *)historySearchCachePath{
    _historySearchCachePath = [historySearchCachePath copy];
    self.searchHistory = nil;
    [self hideHistorySearch];
}

#pragma mark - dealloc
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return self.navigationController.childViewControllers.count > 1;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.baseSearchTableView.tableFooterView.hidden = 0 == self.searchHistory.count||!self.showSearchHistory;
    return self.searchHistory.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = setColorWithRed(113, 113, 113, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.backgroundColor = [UIColor clearColor];
        
        UIButton *closetButton = [[UIButton alloc] init];
        closetButton.size = CGSizeMake(cell.height, cell.height);
        [closetButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        UIImageView *closeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"close"]];
        [closetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
        closeView.contentMode = UIViewContentModeCenter;
        cell.accessoryView = closetButton;
        UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-content-line"]];
        line.height = 0.5;
        line.alpha = 0.7;
        line.x = SEARCH_MARGIN;
        line.y = 43;
        line.width = tableView.width;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [cell.contentView addSubview:line];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"search_history"];
    cell.textLabel.text = self.searchHistory[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.hotHistorySearchTitle.length ? self.hotHistorySearchTitle :  @"历史记录";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - UITableViewdelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.searchBar.text = cell.textLabel.text;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     [self searchBarSearchButtonClicked:self.searchBar];
}

#pragma mark UISearchBarDelegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self saveSearchCacheWithRefreshView];

    if(self.searchBlock){
        self.searchBlock(self, searchBar, searchBar.text);
        [self saveSearchCacheWithRefreshView];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self handleResultShow];
    self.resultShowController.view.hidden = 0 == searchText.length;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
