//
//  ljwcodeNavigationViewController.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/26.
//

#import "ljwcodeNavigationViewController.h"

@interface ljwcodeNavigationViewController ()

@end

@implementation ljwcodeNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
}

#pragma mark ------- setter && getter

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle {
    _statusBarStyle = statusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)setTitleColor:(UIColor *)titleColor {
    NSDictionary *attr = @{NSForegroundColorAttributeName:titleColor};
    [self.navigationBar setTitleTextAttributes:attr];
}

-(void)setBarTintColor:(UIColor *)barTintColor {
    self.navigationBar.tintColor = barTintColor;
}

-(void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    for(UIView *view in self.navigationBar.subviews){
        if([view isMemberOfClass:NSClassFromString(@"_UIBarBackground")]){
            view.backgroundColor = barBackgroundColor;
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return self.statusBarStyle;
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
