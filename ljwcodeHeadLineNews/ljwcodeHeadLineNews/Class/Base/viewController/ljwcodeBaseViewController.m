//
//  ljwcodeBaseViewController.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeBaseViewController.h"
#import "headLineSearchViewController.h"

@interface ljwcodeBaseViewController ()<UIGestureRecognizerDelegate,headLineSearchViewControllerDelegate>

@end

@implementation ljwcodeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ljwcodeNavigationBar *navBar = [self showNaviBar];
    
    [navBar.navigationBarActionSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

-(ljwcodeNavigationBar *)showNaviBar
{
    self.navigationController.navigationBar.hidden = YES;
    ljwcodeNavigationBar *navBar = [ljwcodeNavigationBar ljwcodeNavigationBar];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    [navBar addGestureRecognizer:tap];
    [self.view addSubview:navBar];
    
    return navBar;
}

-(void)tapHandle:(UITapGestureRecognizer *)tap{
    NSLog(@"点击搜索搜索");
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    __block headLineSearchViewController *searchViewController = [headLineSearchViewController searchViewControllerWithHotSearchies:hotSeaches searchControllerPlaceHolder:@"搜索" searchBlock:^(headLineSearchViewController * _Nonnull searchController, UISearchBar * _Nonnull searchBar, NSString * _Nonnull searchText) {
        [searchViewController.navigationController pushViewController:self animated:YES];
    }];
//    searchViewController.delegte = self;
    searchViewController.hotSearchStyle = 0;
    [self.navigationController pushViewController:searchViewController animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
