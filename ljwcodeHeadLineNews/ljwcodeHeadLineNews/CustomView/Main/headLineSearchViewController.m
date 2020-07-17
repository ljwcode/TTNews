//
//  headLineSearchViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "headLineSearchViewController.h"
#import <UIView+LBFrame.h>

@interface headLineSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,weak)UIView *headView;

@property(nonatomic,weak)UIView *hotSearchView;

@property(nonatomic,weak)UIView *searchHistoryView;

@property(nonatomic,strong)NSMutableArray *searchHistory;

@property(nonatomic,weak)UISearchBar *searchBar;

@property(nonatomic,weak)UITextField *searchTextfield;

@property(nonatomic,assign)CGFloat cancelBtnWidth;

@property(nonatomic,weak)UITableView *baseSearchTableView;

@property(nonatomic,strong)UIViewController *searchViewController;

@property(nonatomic,strong)NSArray<NSString *> *hotSearchies;

@property(nonatomic,copy)didSearchBlock searchBlock;

@property(nonatomic,weak)UIButton *emptyButton;

@property(nonatomic,weak)UILabel *searchHistoryLabel;

@property(nonatomic,weak)UIView *searchHistoryTagContentView;


@property(nonatomic,copy)NSString *historySearchCachePath;

@property(nonatomic,weak)UIButton *cancelButton;

@property(nonatomic,weak)UIButton *backButton;

@property(nonatomic,strong)UIBarButtonItem *cancelBarButtonItem;

@property(nonatomic,strong)UIBarButtonItem *backBarButtonItem;

@property(nonatomic,weak)UILabel *hotSearchHeaderLabel;

@property(nonatomic,weak)UIView *hotSearchTagContentView;

@property(nonatomic,weak)UILabel *emptySearchHistoryLabel;

@property(nonatomic,copy)NSArray<UILabel *> *rankTextLabels;

@property(nonatomic,copy)NSArray<UILabel *> *rankTags;

@property(nonatomic,copy)NSArray<UIView *> *rankViews;

@property(nonatomic,assign)BOOL swapHotSeachWithSearchHistory;

@property(nonatomic,assign)CGFloat searchBarCornerRadius;

@property(nonatomic,copy)NSString *hotSearchTitle;

@property(nonatomic,copy)NSString *hotHistorySearchTitle;

@property(nonatomic,assign)BOOL showSearchHistory;

@property(nonatomic,assign)BOOL showKeyboard;

@end

@implementation headLineSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat adaptWidth = 0;
    UISearchBar *searchBar = self.searchBar;
    UITextField *searchTextfield = self.searchTextfield;
    UIView *titleView = self.navigationItem.titleView;
    UIButton *backButton = self.navigationItem.leftBarButtonItem.customView;
    UIButton *cancelButton = self.navigationItem.rightBarButtonItem.customView;
    
    UIEdgeInsets backBtnEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets cancelBtnEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets navigationBarLyaoutEdgeInsets = UIEdgeInsetsZero;
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    if(@available(iOS 8.0,*)){
        backButton.layoutMargins = UIEdgeInsetsMake(8, 0, 8, 8);
        backBtnEdgeInsets = backButton.layoutMargins;
        cancelButton.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 0);
        cancelBtnEdgeInsets = cancelButton.layoutMargins;
        navigationBarLyaoutEdgeInsets = navigationBar.layoutMargins;
    }
    
    adaptWidth = adaptWidth + navigationBarLyaoutEdgeInsets.left + navigationBarLyaoutEdgeInsets.right;
    if(@available(iOS 11.0,*)){
        NSLayoutConstraint *leftLayoutConstaaint = [navigationBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor];
        if(navigationBarLyaoutEdgeInsets.left > SEARCH_MARGIN){
            [leftLayoutConstaaint setConstant:0];
        }else{
            [leftLayoutConstaaint setConstant:10-navigationBarLyaoutEdgeInsets.left];
        }
        searchBar.height = self.view.width>self.view.height ? 24 : 30;
        searchBar.width = self.view.width - SEARCH_MARGIN - adaptWidth;
        searchTextfield.frame = searchBar.bounds;
        cancelButton.width = self.cancelBtnWidth;
    }else{
        titleView.x = self.view.width > self.view.height ? 4 : 7;
        titleView.y = SEARCH_MARGIN * 1.5;
        titleView.height = self.view.width > self.view.height ? 24 : 30;
        titleView.width = self.view.width - titleView.x * 2 - 3;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self viewDidLayoutSubviews];
}

-(BOOL)prefersStatusBarHidden{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.cancelBtnWidth == 0){
        [self viewDidLayoutSubviews];
    }
    
    if(self.navigationController.navigationBar.translucent == NO){
        self.baseSearchTableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.y, 0);
        if(!self.navigationController.navigationBar.barTintColor){
            self.navigationController.navigationBar.barTintColor = setColorWithRed(249, 249, 249, 1);
        }
    }
    if(self.searchViewController.parentViewController == NULL){
        [self.searchBar becomeFirstResponder];
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

#pragma mark - 外部初始化调用方法
+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *> *)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder{
    headLineSearchViewController *searchVC = [[headLineSearchViewController alloc]init];
    searchVC.hotSearchies = hotSearchies;
    searchVC.searchBar.placeholder = placeHolder;
    return searchVC;
}

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *> *)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock{
    headLineSearchViewController *headLineSearchVC = [[headLineSearchViewController alloc]init];
    [self searchViewControllerWithHotSearchies:hotSearchies searchControllerPlaceHolder:placeHolder];
    headLineSearchVC.searchBlock = [searchBlock copy];
    return headLineSearchVC;
}

#pragma mark - 视图懒加载
-(UITableView *)baseSearchTableView{
    if(!_baseSearchTableView){
        UITableView *baseTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        baseTableView.backgroundColor = [UIColor clearColor];
        baseTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if([baseTableView respondsToSelector:@selector(cellLayoutMarginsFollowReadableWidth)]){
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
        emptyButton.x = self.searchHistoryView.width - emptyButton.width;
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
        [self.headView addSubview:searchHistoryView];
        _searchHistoryView = searchHistoryView;
    }
    return _searchHistoryView;
}

-(UILabel *)searchHistoryLabel{
    if(!_searchHistoryLabel){
        UILabel *titleLabel = [self setUpTitleLabelText:@"历史搜索"];
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
        searchHistoryTagContentView.y = CGRectGetMaxY(searchHistoryTagContentView.frame) + SEARCH_MARGIN;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.baseSearchTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.navigationController.navigationBar.backIndicatorImage = nil;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:setColorWithRed(113, 113, 113, 1) forState:UIControlStateNormal];
    cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [cancelButton addTarget:self action:@selector(cancelButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton sizeToFit];
    cancelButton.width += SEARCH_MARGIN;
    self.cancelButton = cancelButton;
    self.cancelBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *backImg = [UIImage imageNamed:@"back"];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setImage:backImg forState:UIControlStateNormal];
    [backButton setTitleColor:setColorWithRed(113, 113, 113, 1) forState:UIControlStateNormal];
    backButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton.imageView sizeToFit];
    [backButton addTarget:self action:@selector(backButtonHandle:) forControlEvents:UIControlEventTouchUpInside];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -ceil(backImg.size.width)/2, 0, 0);
    [backButton sizeToFit];
    backButton.width += 3;
    self.backButton = backButton;
    self.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIView *titleView = [[UIView alloc] init];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
    [titleView addSubview:searchBar];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
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
    searchBar.placeholder = @"搜你想搜";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    for (UIView *subView in [[searchBar.subviews lastObject] subviews]) {
        if ([[subView class] isSubclassOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)subView;
            textField.font = [UIFont systemFontOfSize:16];
            _searchTextfield = textField;
            break;
        }
    }
    self.searchBar = searchBar;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.width = kScreenWidth;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIView *hotSearchView = [[UIView alloc] init];
    hotSearchView.x = SEARCH_MARGIN * 1.5;
    hotSearchView.width = headerView.width - hotSearchView.x * 2;
    hotSearchView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UILabel *titleLabel = [self setUpTitleLabelText:@"搜索"];
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
    footerView.width = kScreenWidth;
    UILabel *emptySearchHistoryLabel = [[UILabel alloc] init];
    emptySearchHistoryLabel.textColor = [UIColor darkGrayColor];
    emptySearchHistoryLabel.font = [UIFont systemFontOfSize:13];
    emptySearchHistoryLabel.userInteractionEnabled = YES;
    emptySearchHistoryLabel.text = @"清空";
    emptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
    emptySearchHistoryLabel.height = 49;
    [emptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick:)]];
    emptySearchHistoryLabel.width = footerView.width;
    emptySearchHistoryLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.emptySearchHistoryLabel = emptySearchHistoryLabel;
    [footerView addSubview:emptySearchHistoryLabel];
    footerView.height = emptySearchHistoryLabel.height;
    self.baseSearchTableView.tableFooterView = footerView;
    
    self.hotSearchies = nil;
}

- (void)setupHotSearchRankTags
{
    UIView *contentView = self.hotSearchTagContentView;
    [self.hotSearchTagContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *rankTextLabelsM = [NSMutableArray array];
    NSMutableArray *rankTagM = [NSMutableArray array];
    NSMutableArray *rankViewM = [NSMutableArray array];
    for (int i = 0; i < self.hotSearchies.count; i++) {
        UIView *rankView = [[UIView alloc] init];
        rankView.height = 40;
        rankView.width = (self.baseSearchTableView.width - SEARCH_MARGIN * 3) * 0.5;
        rankView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:rankView];
        // rank tag
        UILabel *rankTag = [[UILabel alloc] init];
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
        // rank text
        UILabel *rankTextLabel = [[UILabel alloc] init];
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
        line.x = -kScreenWidth * 0.5;
        line.y = rankView.height - 1;
        line.width = self.baseSearchTableView.width;
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [rankView addSubview:line];
        [rankViewM addObject:rankView];
        
        switch (i) {
            case 0:
                rankTag.backgroundColor = [UIColor redColor];
                rankTag.textColor = [UIColor whiteColor];
                break;
            case 1:
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = [UIColor blueColor];
                break;
            case 2:
                rankTag.textColor = [UIColor whiteColor];
                rankTag.backgroundColor = [UIColor greenColor];
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
    [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
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

#pragma mark - 事件响应

-(void)emptyButtonHandle:(UIButton *)sender{
    
}

-(void)emptySearchHistoryDidClick:(UITapGestureRecognizer *)tap{
    
}

-(void)backButtonHandle:(UIButton *)sender{
    
}

-(void)cancelButtonHandle:(UIButton *)sender{
    
}

-(void)keyBoardDidShow:(NSNotification *)noti{
    
}

-(void)tagDidCLick:(UITapGestureRecognizer *)tap{
    
}

#pragma mark - setter

-(void)setRankTextLabels:(NSArray<UILabel *> *)rankTextLabels{
    for(UILabel *label in rankTextLabels){
        [label setTag:1];
    }
    _rankTextLabels = rankTextLabels;
}

//设置searchBar圆角
-(void)setSearchBarCornerRadius:(CGFloat)searchBarCornerRadius{
    _searchBarCornerRadius = searchBarCornerRadius;
    for(UIView *view in self.searchTextfield.subviews){
        if([NSStringFromClass([view class]) isEqualToString:@"_UISearchBarSearchFieldBackgroundView"]){
            view.layer.cornerRadius = searchBarCornerRadius;
            view.clipsToBounds = YES;
            break;
        }
    }
}

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
    if(!cellID){
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - UITableViewdelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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
