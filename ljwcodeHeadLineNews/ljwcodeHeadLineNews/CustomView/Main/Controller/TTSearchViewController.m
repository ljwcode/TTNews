//
//  TTSearchViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTSearchViewController.h"
#import "TTArticleSearchInboxFourWordsCell.h"
#import "TTArticleSearchInboxFourWordsModel.h"
#import "TTArticleSearchHeaderCell.h"
#import "TTArticleSearchTagCell.h"

static NSString *const TTArticleSearchInboxFourWordsCellID = @"TTArticleSearchInboxFourWordsCell";
static NSString *const TTArticleSearchHeaderCellID = @"TTArticleSearchHeaderCell";
static NSString *const TTArticleSearchTagCellID = @"TTArticleSearchTagCell";

@interface TTSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSMutableArray *searchHistory;

@property(nonatomic,strong)NSMutableArray *recommendSearchArray;

@property(nonatomic,weak)UISearchBar *searchBar;

@property(nonatomic,weak)UITextField *searchTextfield;

@property(nonatomic,assign)CGFloat cancelBtnWidth;

@property(nonatomic,strong)UITableView *baseSearchTableView;

@property(nonatomic,copy)didSearchBlock searchBlock;


@property(nonatomic,copy)NSString *historySearchCachePath;

@property(nonatomic,weak)UIButton *cancelButton;

@property(nonatomic,strong)UIBarButtonItem *cancelBarButtonItem;

@property(nonatomic,assign)BOOL showSearchHistory;

@property(nonatomic,strong)UIColor *searchBarBackgroundColor;

@property(nonatomic,assign)BOOL removeSpaceOnSearchString;

@property(nonatomic,assign)NSUInteger searchHistoryCount;

@property(nonatomic,assign)UIDeviceOrientation currentOrientation;

@property(nonatomic,strong)TTArticleSearchInboxFourWordsModel *searchKeyWordModel;

@end

@implementation TTSearchViewController

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

-(UIImage *)drawImageContext:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 取消searchBar背景色 */
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
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
        self.searchHistory = self.searchHistory;
        self.currentOrientation = [UIDevice currentDevice].orientation;
    }
    CGFloat adaptWidth = 0;
    UISearchBar *searchBar = self.searchBar;
    UITextField *searchTextfield = [self.searchBar valueForKey:@"searchField"];
    searchTextfield = self.searchTextfield;
    searchTextfield = [self.searchBar valueForKey:@"searchField"];
    searchTextfield.backgroundColor = [UIColor lightGrayColor];
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
        searchTextfield.layer.cornerRadius = 13.f;
        searchTextfield.layer.masksToBounds = YES;
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
    
    if(self.cancelBtnWidth == 0){
        [self viewDidLayoutSubviews];
    }
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    
    self.navigationController.navigationBarHidden = NO;
    
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
    TTSearchViewController *searchVC = [[self alloc]init];
    searchVC.searchBar.placeholder = placeHolder;
    return searchVC;
}

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *> *)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock{
    TTSearchViewController *headLineSearchVC = [self searchViewControllerWithHotSearchies:hotSearchies searchControllerPlaceHolder:placeHolder];
    headLineSearchVC.searchBlock = [searchBlock copy];
    return headLineSearchVC;
}

#pragma mark - lazy load
-(UITableView *)baseSearchTableView{
    if(!_baseSearchTableView){
        _baseSearchTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _baseSearchTableView.backgroundColor = [UIColor clearColor];
        _baseSearchTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if([_baseSearchTableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]){
            _baseSearchTableView.cellLayoutMarginsFollowReadableWidth = NO;
        }
        _baseSearchTableView.delegate = self;
        _baseSearchTableView.dataSource = self;
        _baseSearchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:_baseSearchTableView];
    }
    return _baseSearchTableView;
}

-(NSMutableArray *)searchHistory{
    if(!_searchHistory){
        _searchHistory = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.historySearchCachePath]];
    }
    return _searchHistory;
}

-(TTArticleSearchInboxFourWordsModel *)searchKeyWordModel{
    if(!_searchKeyWordModel){
        _searchKeyWordModel = [[TTArticleSearchInboxFourWordsModel alloc]init];
    }
    return _searchKeyWordModel;
}

-(NSArray *)keywordArray{
    if(!_keywordArray){
        _keywordArray = [NSArray array];
    }
    return _keywordArray;
}

-(void)setup{
    self.showSearchHistory = YES;
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
            self.searchTextfield.layer.cornerRadius = 13.f;
            break;
        }
    }
    self.searchBar = searchBar;
    
#pragma mark ----- footer view ------------
    
    UIView *footerView = [[UIView alloc] init];
    footerView.width = kCompareScreenWidth;
    footerView.height = 60;
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [footerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    UILabel *PrivateSearchLabel = [[UILabel alloc]init];
    PrivateSearchLabel.textColor = [UIColor blackColor];
    PrivateSearchLabel.text = @"无痕搜索模式";
    PrivateSearchLabel.font = [UIFont systemFontOfSize:15.f];
    PrivateSearchLabel.adjustsFontSizeToFitWidth = YES;
    [footerView addSubview:PrivateSearchLabel];
    [PrivateSearchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hSpace);
        make.centerY.mas_equalTo(footerView);
        make.height.mas_equalTo(footerView.height/2);
        make.width.mas_equalTo(80);
    }];
    
    UISwitch *privateSwitch = [[UISwitch alloc]init];
    privateSwitch.on = false;
    [footerView addSubview:privateSwitch];
    [privateSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-hSpace);
        make.centerY.mas_equalTo(footerView);
        make.height.mas_equalTo(footerView.height/2);
        make.width.mas_equalTo(60);
    }];
    self.baseSearchTableView.tableFooterView = footerView;
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
}

#pragma mark - 事件响应


-(void)cancelButtonHandle:(UIButton *)sender{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)keyBoardDidShow:(NSNotification *)noti{
    
}

-(void)clearHandle:(UIButton *)sender{
    
}

#pragma mark - setter

-(void)setCancelBarButtonItem:(UIBarButtonItem *)cancelBarButtonItem{
    _cancelBarButtonItem = cancelBarButtonItem;
    self.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

-(void)setCancelButton:(UIButton *)cancelButton{
    _cancelButton = cancelButton;
    self.navigationItem.rightBarButtonItem.customView = cancelButton;
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 1 + self.recommendSearchArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *ResultCell = nil;
    if(indexPath.section == 0){
        TTArticleSearchInboxFourWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:TTArticleSearchInboxFourWordsCellID];
        if(!cell){
            cell = [[TTArticleSearchInboxFourWordsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTArticleSearchInboxFourWordsCellID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for(int i = 0;i < 2;i++){
            TTArticleSearchInboxFourWordsModel *model = self.keywordArray[i];
            cell.SearchWordsModel = model;
        }
        
        ResultCell = cell;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            TTArticleSearchHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:TTArticleSearchHeaderCellID];
            if(!cell){
                cell = [[TTArticleSearchHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTArticleSearchHeaderCellID];
            }
            cell.titleLabel.text = @"搜索历史";
            [cell.actionBtn setImage:[UIImage imageNamed:@"empty"] forState:UIControlStateNormal];
            ResultCell = cell;
        }else{
            TTArticleSearchTagCell *cell = [tableView dequeueReusableCellWithIdentifier:TTArticleSearchTagCellID];
            if(!cell){
                cell = [[TTArticleSearchTagCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TTArticleSearchTagCellID];
            }
            
        }
    }
    
    return ResultCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
