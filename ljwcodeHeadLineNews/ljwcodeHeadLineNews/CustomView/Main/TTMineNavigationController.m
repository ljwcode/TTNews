//
//  TTMineNavigationController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTMineNavigationController.h"

@interface TTMineNavigationController()

@property(nonatomic,strong)UIImage *defaultImage;

@end

@implementation TTMineNavigationController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

+(void)initialize
{
    
    [[UINavigationBar appearance]setTranslucent:NO];//不透明
    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.f],NSFontAttributeName, nil]];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.f],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UINavigationBar appearance]setBackgroundImage:[self drawImageContext:[UIColor purpleColor]] forBarMetrics:UIBarMetricsDefault];
    
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

- (void)viewDidLoad {
    [super viewDidLoad];
 
    _defaultImage = [self.class drawImageContext:[UIColor colorWithRed:0.83 green:0.24 blue:0.24 alpha:1]];
    // Do any additional setup after loading the view.
}

@end

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
