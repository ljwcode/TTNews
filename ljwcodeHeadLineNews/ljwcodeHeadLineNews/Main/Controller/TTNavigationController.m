//
//  ljwcodeNavigationController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTNavigationController.h"

@interface TTNavigationController ()<UIBarPositioningDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIImage *defaultImage;

@end

@implementation TTNavigationController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

+(void)initialize{
    [[UINavigationBar appearance]setTranslucent:NO];//不透明
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.f],NSFontAttributeName, nil]];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UINavigationBar appearance]setBackgroundImage:[self drawImageContext:[UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance]setHidden:YES];
}


+(UIImage *)drawImageContext:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.childViewControllers.count >= 1){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _defaultImage = [self.class drawImageContext:[UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1]];

    id target = self.interactivePopGestureRecognizer.delegate;
    self.interactivePopGestureRecognizer.enabled = NO;
    SEL selector = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:selector];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    // Do any additional setup after loading the view.
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
       BOOL open = self.viewControllers.count > 1;
       return open;
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
