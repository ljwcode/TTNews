//
//  TTBaseViewController.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTBaseViewController.h"
#import "headLineSearchViewController.h"
#import "reportButton.h"
#import <UIView+Frame.h>

@interface TTBaseViewController ()<UIGestureRecognizerDelegate,UISearchBarDelegate>

@property(nonatomic,strong)TTNavigationBar *naviBar;

@end

@implementation TTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    reportButton *messageButton = [[reportButton alloc]initWithBtnText:@"发布" BtnImgView:@"add_channel_titlbar_thin_new_16x16_"];
    messageButton.frame = CGRectMake(0, 0, 30, 30);
    
    UIBarButtonItem *messageBarButton = [[UIBarButtonItem alloc] initWithCustomView:messageButton];
    self.navigationItem.rightBarButtonItem = messageBarButton;
    
    // search bar
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    leftView.bounds = CGRectMake(0, 0, 24, 24);
    self.naviBar = [[TTNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)
                                              placeholder:@"搜一搜"
                                        textFieldLeftView:leftView
                                         showCancelButton:NO
                                                tintColor:[UIColor whiteColor]];
    self.naviBar.layer.cornerRadius = 16.f;
    self.navigationItem.titleView = self.naviBar;
    self.naviBar.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSArray *hotSeaches = @[@"Swift", @"Python", @"Objective-C", @"Java", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    
    __block headLineSearchViewController *searchViewController = [headLineSearchViewController searchViewControllerWithHotSearchies:hotSeaches searchControllerPlaceHolder:hotSeaches[0] searchBlock:^(headLineSearchViewController * _Nonnull searchController, UISearchBar * _Nonnull searchBar, NSString * _Nonnull searchText) {
        [searchViewController.navigationController pushViewController:self animated:YES];
    }];
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
