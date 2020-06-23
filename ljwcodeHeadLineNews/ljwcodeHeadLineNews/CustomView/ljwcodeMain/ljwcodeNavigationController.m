//
//  ljwcodeNavigationController.m
//
//
//  Created by ljwcode on 2020/6/18.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodeNavigationController.h"

@interface ljwcodeNavigationController ()<UIGestureRecognizerDelegate,UIBarPositioningDelegate>

@property(nonatomic,strong)UIPanGestureRecognizer *pan;

@end

@implementation ljwcodeNavigationController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

+(void)initialize
{
    
    [[UINavigationBar appearance]setTranslucent:NO];//不透明
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:13.f],NSFontAttributeName, nil]];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UINavigationBar appearance]setBackgroundImage:[self drawImageContext:[UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1.0]] forBarMetrics:UIBarMetricsDefault];
    
}

-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar
{
    //设置NavigationBar通顶
    return UIBarPositionTopAttached;
    
}

+(UIImage *)drawImageContext:(UIColor *)color
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
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count >= 1)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    _defaultImage = [self.class drawImageContext:[UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1]];
    [self addGedtureRec];
    // Do any additional setup after loading the view.
}

-(void)addGedtureRec
{
    id target = self.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:target action:@selector(handleNavigationTransition:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

-(void)startGestureRecnozier
{
    [self.view addGestureRecognizer:_pan];
}

-(void)stopGestureRecnozier
{
    [self.view removeGestureRecognizer:_pan];
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
