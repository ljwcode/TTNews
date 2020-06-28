//
//  ljwcodeBaseViewController.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeBaseViewController.h"

@interface ljwcodeBaseViewController ()

@end

@implementation ljwcodeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

-(ljwcodeNavigationBar *)showNaviBar
{
    self.navigationController.navigationBar.hidden = YES;
    ljwcodeNavigationBar *navBar = [ljwcodeNavigationBar ljwcodeNavigationBar];
    [self.view addSubview:navBar];
    
    return navBar;
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
