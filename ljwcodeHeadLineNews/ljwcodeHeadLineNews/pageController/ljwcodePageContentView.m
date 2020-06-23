//
//  ljwcodePageContentView.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodePageContentView.h"

@interface ljwcodePageContentView()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger beforeIndex;

@end

@implementation ljwcodePageContentView

//初始化子控制器
-(instancetype)initWithFrame:(CGRect)frame childViewController:(NSArray *)childViewControllers
{
    if(self = [super initWithFrame:frame])
    {
        self.pageViewController.view.frame = self.bounds;
        self.controllerArray = childViewControllers;
        if ([self.pageViewController.view.subviews.firstObject isKindOfClass:[UIScrollView class]]) {
        _scrollView = self.pageViewController.view.subviews.firstObject;
        _scrollView.delegate = self;
        }
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if([self viewController] != nil)
    {
        [[self viewController] addChildViewController:self.pageViewController];
    }
    
}

//控制器响应者
-(UIViewController *)viewController
{
    UIResponder *responder = self.nextResponder;
    while(responder != nil)
    {
        if([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

//滑动至某一个控制器
-(void)pageContentViewScrollerToIndex:(NSInteger)index beforeIndex:(NSInteger)beforeIndex
{
    __strong typeof(self) strongSelf = self;
    if(beforeIndex < index)
    {
        [self.pageViewController setViewControllers:self.controllerArray[index] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            if(finished)
            {
                if(@available(iOS 13.0,*)){
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf.pageViewController setViewControllers:strongSelf.controllerArray[index] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
                    });
                }
            }
        }];
    }else{
        [self.pageViewController setViewControllers:self.controllerArray[index] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:^(BOOL finished) {
            if(finished){
                if(@available(iOS 13.0,*)){
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf.pageViewController setViewControllers:strongSelf.controllerArray[index] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
                    });
                }
            }
        }];
        
    }
}

-(NSInteger)indexOfChildViewController:(UIViewController *)controller
{
    return [self.controllerArray indexOfObject:controller];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
