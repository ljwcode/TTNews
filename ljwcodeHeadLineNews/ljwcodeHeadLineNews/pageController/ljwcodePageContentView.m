//
//  ljwcodePageContentView.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "ljwcodePageContentView.h"

@interface ljwcodePageContentView()<UIPageViewControllerDataSource,UIScrollViewDelegate,ljwcodePageContentViewDelegate,UIPageViewControllerDelegate>

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
        [self.pageViewController setViewControllers:@[self.controllerArray[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:^(BOOL finished) {
            if(finished)
            {
                if(@available(iOS 13.0,*)){
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [strongSelf.pageViewController setViewControllers:@[strongSelf.controllerArray[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
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
                        [strongSelf.pageViewController setViewControllers:@[strongSelf.controllerArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
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

#pragma mark - UIPageViewControllerDatasource

//返回pageViewController的数量
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.controllerArray.count;
}

//@require
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfChildViewController:viewController];
    if(index == 0|| index == NSNotFound)
    {
        return nil;
    }
    index --;
    return [self.controllerArray objectAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self indexOfChildViewController:viewController];
    if(index == self.controllerArray.count-1 || index == NSNotFound)
    {
        return nil;
    }
    index ++;
    return [self.controllerArray objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
//    UIViewController *nextVC = [pendingViewControllers firstObject];
//    NSInteger index = [self indexOfChildViewController:nextVC];
//    _beforeIndex = index;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *nextVC = self.pageViewController.viewControllers.firstObject;
    NSInteger index = [self indexOfChildViewController:nextVC];
    if(self.pageContentViewDidScroll)
    {
        self.pageContentViewDidScroll(index, _beforeIndex, self);
    }else{
        if([self.delegate respondsToSelector:@selector(pageContentViewDidScrollerViewIndex:beforeIndex:)]){
            [self.delegate pageContentViewDidScrollerViewIndex:index beforeIndex:_beforeIndex];
        }
    }
    _beforeIndex = index;
}

#pragma mark - UIScrollerViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float trasitionProgress = (scrollView.contentOffset.x - self.width)/self.width;
    NSLog(@"%.2f",trasitionProgress);
}

#pragma mark - getter

-(UIPageViewController *)pageViewController
{
    if(!_pageViewController)
    {
        _pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:UIPageViewControllerOptionInterPageSpacingKey]];
        if(self.controllerArray.count){
            [_pageViewController setViewControllers:@[self.controllerArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        }
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        [self addSubview:_pageViewController.view];
        
    }
    return _pageViewController;
}

#pragma mark - setter

- (void)setControllerArray:(NSArray *)controllerArray {
    if (_controllerArray!=controllerArray) {
        _controllerArray = controllerArray;
    }
    if (_controllerArray.count) {
        _beforeIndex = 0;
        [self.pageViewController setViewControllers:@[self.controllerArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        }];
    }
}

//释放
- (void)dealloc{
    NSLog(@"%@🔥🔥🔥🔥",NSStringFromClass(self.class));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
