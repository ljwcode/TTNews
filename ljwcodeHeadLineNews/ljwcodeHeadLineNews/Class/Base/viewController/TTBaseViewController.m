//
//  TTBaseViewController.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTBaseViewController.h"
#import "headLineSearchViewController.h"
#import "TTNavigationBar.h"
#import "TTSearchSuggestionViewModel.h"
#import "TTReportArticleView.h"

@interface TTBaseViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>

@property(nonatomic,strong)TTNavigationBar *naviBar;

@property(nonatomic,strong)TTSearchSuggestionViewModel *viewModel;

@property(nonatomic,strong)TTReportArticleView *ReportArticleView;

@end

@implementation TTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSearchBar];
        // Do any additional setup after loading the view.
}

-(void)createSearchBar{
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
     
     UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icons_search"]];
     leftView.bounds = CGRectMake(0, 0, 24, 24);
    
    __block NSString *placeHolder = @"";
    [[self.viewModel.SearchSuggestionCommand execute:@"title"]subscribeNext:^(id  _Nullable x) {
        placeHolder = x;
        self.naviBar = [[TTNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44) placeholder:x textFieldLeftView:leftView tintColor:[UIColor whiteColor]];
        self.navigationItem.titleView = self.naviBar;
        self.naviBar.delegate = self;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }];
     
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSArray *hotSeaches = @[@"Swift", @"Python", @"Objective-C", @"Java", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    headLineSearchViewController *searchViewController = [headLineSearchViewController searchViewControllerWithHotSearchies:hotSeaches searchControllerPlaceHolder:hotSeaches[0] searchBlock:^(headLineSearchViewController * _Nonnull searchController, UISearchBar * _Nonnull searchBar, NSString * _Nonnull searchText) {
    }];
    searchViewController.hotSearchStyle = 0;
//    [self.navigationController pushViewController:searchViewController animated:YES];
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

-(void)leftItemAction
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
