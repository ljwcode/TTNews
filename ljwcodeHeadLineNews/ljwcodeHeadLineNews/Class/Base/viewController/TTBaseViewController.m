//
//  TTBaseViewController.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTSearchViewController.h"
#import "TTNavigationBar.h"
#import "TTSearchSuggestionViewModel.h"
#import "TTReportArticleView.h"
#import <FBLPromises/FBLPromise.h>
#import <FBLPromises/FBLPromises.h>
#import "TTArticleSearchInboxFourWordsModel.h"
#import "TTArticleSearchWordViewModel.h"
#import "TTDBCacheSearchKeywordViewModel.h"
#import "TTSearchKeywordModel.h"

@interface TTBaseViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>

@property(nonatomic,strong)TTNavigationBar *naviBar;

@property(nonatomic,strong)TTSearchSuggestionViewModel *viewModel;

@property(nonatomic,strong)TTReportArticleView *ReportArticleView;

@property(nonatomic,strong)TTSearchViewController *searchVC;

@property(nonatomic,strong)TTArticleSearchWordViewModel *keywordViewModel;

@property(nonatomic,strong)TTDBCacheSearchKeywordViewModel *SearchCacheViewModel;

@property(nonatomic,copy)NSString *placeHoldText;

@property(nonatomic,strong)UIImageView *leftView;

@property(nonatomic,strong)NSArray *keywordModelArray;

@end

@implementation TTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSearchBar];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([self.SearchCacheViewModel IsExistsKeywordCacheTable]){
      self.keywordModelArray = [self.SearchCacheViewModel queryDBTableWithVideoContent];
    }
}

-(void)createSearchBar{
    [self createNavSearchBarView];
    [[FBLPromise do:^id _Nullable{
        return [self getPlaceholderText];
    }] then:^id _Nullable(id  _Nullable value) {
        return self.naviBar.placeholder = value;
    }];
}

-(void)createNavSearchBarView{
    UIButton *reportBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reportBtn setTitle:@"发布" forState:UIControlStateNormal];
    [reportBtn setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    reportBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
    [reportBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    reportBtn.contentMode = UIViewContentModeScaleAspectFit;
    reportBtn.imageEdgeInsets = UIEdgeInsetsMake(-reportBtn.titleLabel.intrinsicContentSize.height/2, 0, 0, 0);
    reportBtn.titleEdgeInsets = UIEdgeInsetsMake(reportBtn.imageView.intrinsicContentSize.height, -reportBtn.imageView.intrinsicContentSize.width, 0, 0);
    [reportBtn addTarget:self action:@selector(reportHandle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
    reportBtn.frame = view.bounds;
    [view addSubview:reportBtn];
    
    UIBarButtonItem *reportBarBtn = [[UIBarButtonItem alloc]initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = reportBarBtn;
    self.navigationItem.titleView = self.naviBar;
}

-(FBLPromise *)getPlaceholderText{
    return [FBLPromise async:^(FBLPromiseFulfillBlock  _Nonnull fulfill, FBLPromiseRejectBlock  _Nonnull reject) {
        [[self.viewModel.SearchSuggestionCommand execute:@"title"]subscribeNext:^(id  _Nullable x) {
            TTSearchKeywordModel *model = x;
            NSArray *array = [model.homepage_search_suggest componentsSeparatedByString:@"|"];
            NSString *keyword = [NSString stringWithFormat:@"%@ | %@",array[0],array[1]];
            fulfill(keyword);
        }];
    }];
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.searchVC];
    [self presentViewController:nav animated:YES completion:nil];
}

//图片显示
-(UIBarButtonItem *)createBarButtonItemWithImage:(NSString *)imageName Selector:(SEL)selector{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0, 0, 21, 21);
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:selector];
    [imageView addGestureRecognizer:panGes];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:imageView];
    
    return item;
}

-(UIBarButtonItem *)configureLeftBarButtonItemWithImage:(NSString *)imageName{
    return self.navigationItem.leftBarButtonItem = [self createBarButtonItemWithImage:imageName Selector:@selector(leftItemAction)];
}

-(UIBarButtonItem *)configureRightBarButtonItemWithImage:(NSString *)imageName{
    return self.navigationItem.rightBarButtonItem = [self createBarButtonItemWithImage:imageName Selector:@selector(rightItemAction)];
}

-(void)leftItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//文字显示
-(UIBarButtonItem *)createBarButtonItemWithText:(NSString *)text Selector:(SEL)selector{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:text style:UIBarButtonItemStylePlain target:self action:selector];
    return item;
}

-(UIBarButtonItem *)configureLeftBarButtonItemWithText:(NSString *)text{
    return self.navigationItem.leftBarButtonItem = [self createBarButtonItemWithText:text Selector:@selector(leftItemAction)];
}

-(UIBarButtonItem *)configureRightBarButtonItemWithText:(NSString *)text{
    return self.navigationItem.rightBarButtonItem = [self createBarButtonItemWithText:text Selector:@selector(rightItemAction)];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark ---- 响应事件

-(void)reportHandle:(UIButton *)sender{
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.ReportArticleView];
}

#pragma mark -- lazy load

-(UIImageView *)leftView{
    if(!_leftView){
        _leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icons_search"]];
        _leftView.bounds = CGRectMake(0, 0, 24, 24);
    }
    return _leftView;
}

-(TTNavigationBar *)naviBar{
    if(!_naviBar){
        _naviBar = [[TTNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _naviBar.delegate = self;
        _naviBar.tintColor = [UIColor whiteColor];
        _naviBar.barTintColor = [UIColor whiteColor];
        _naviBar.barStyle = UIBarStyleDefault;
        _naviBar.leftView = self.leftView;
    }
    return _naviBar;
}

-(TTReportArticleView *)ReportArticleView{
    if(!_ReportArticleView){
        _ReportArticleView = [[TTReportArticleView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.5, kScreenWidth, kScreenHeight * 0.5)];
        _ReportArticleView.backgroundColor = [UIColor whiteColor];
        _ReportArticleView.layer.cornerRadius = 5.f;
    }
    return _ReportArticleView;
}

-(TTSearchSuggestionViewModel *)viewModel{
    if(!_viewModel){
        _viewModel = [[TTSearchSuggestionViewModel alloc]init];
    }
    return _viewModel;
}

-(TTArticleSearchWordViewModel *)keywordViewModel{
    if(!_keywordViewModel){
        _keywordViewModel = [[TTArticleSearchWordViewModel alloc]init];
    }
    return _keywordViewModel;
}

-(TTDBCacheSearchKeywordViewModel *)SearchCacheViewModel{
    if(!_SearchCacheViewModel){
        _SearchCacheViewModel = [[TTDBCacheSearchKeywordViewModel alloc]init];
    }
    return _SearchCacheViewModel;
}

-(NSArray *)keywordModelArray{
    if(!_keywordModelArray){
        _keywordModelArray = [[NSArray alloc]init];
    }
    return _keywordModelArray;
}

-(TTSearchViewController *)searchVC{
    if(!_searchVC){
        NSArray *hotSeaches = @[@"Swift", @"Python", @"Objective-C", @"Java", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
        _searchVC = [TTSearchViewController searchViewControllerWithHotSearchies:hotSeaches searchControllerPlaceHolder:hotSeaches[0] searchBlock:^(TTSearchViewController * _Nonnull searchController, UISearchBar * _Nonnull searchBar, NSString * _Nonnull searchText) {
        }];
        _searchVC.hotSearchStyle = 0;
    }
    return _searchVC;
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
