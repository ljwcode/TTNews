//
//  ljwcodePageViewController.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/14.
//

#import "ljwcodePageViewController.h"
#import "ljwcodePageBasicTitleView.h"
#import "ljwcodePageSegmentedTitleView.h"

static float viewControllerMethodDelay = 0.1;

typedef void(^contentScrollBlock)(BOOL scrollEnable);

@interface ljwcodePageContentView : UIView

@property(nonatomic,copy)contentScrollBlock scrollBlock;

@end
 
@implementation ljwcodePageContentView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    BOOL pageViewScrollEnable = !view.priorityScrollAtFirst;
    if(self.scrollBlock){
        self.scrollBlock(pageViewScrollEnable);
    }
    return view;
}

@end

@interface ljwcodePageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,UIScrollViewDelegate,ljwcodePageBasicTitleViewDelegate,ljwcodePageBasicTitleViewDatasource>

@property(nonatomic,strong)ljwcodePageContentView *contentView;

@property(nonatomic,strong)UIPageViewController *pageVC;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSMutableArray *showVCArray;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,assign)BOOL isDidLoadVC;

@property(nonatomic,assign)BOOL isAnimaitonVC;

@property(nonatomic,assign)NSInteger lastDelegateIndex;

@property(nonatomic,assign)CGFloat dragStartX;

@property(nonatomic,strong)ljwcodePageViewControllerConfig *config;

@property(nonatomic,strong)ljwcodePageBasicTitleView *titleView;

@end

@implementation ljwcodePageViewController

-(instancetype)init{
    if(self = [super init]){
        [NSException raise:@"Do not use this method" format:@"Must be initialized by initWithConfig"];
    }
    return self;
}

-(instancetype)initWithConfig:(ljwcodePageViewControllerConfig *)config{
    if(self = [super init]){
        [self initUIWithConfig:config];
        [self initWithData];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.config.showTitleViewInNavigationBar){
        self.parentViewController.navigationItem.titleView = self.titleView;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initUIWithConfig:(ljwcodePageViewControllerConfig *)config {
    self.config = config;
    self.contentView = [[ljwcodePageContentView alloc]init];
    [self.view addSubview:self.contentView];
    __weak typeof(self) weakSelf = self;
    self.contentView.scrollBlock = ^(BOOL scrollEnable) {
        if(weakSelf.scrollEnable){
            weakSelf.scrollView.scrollEnabled = scrollEnable;
        }
    };
    
    UIView *topView = [[UIView alloc]init];
    [self.contentView addSubview:topView];
    
    self.titleView = [[ljwcodePageBasicTitleView alloc]initWithConfig:config];
    if(config.titleViewStyle == ljwcodeTitleViewStyleSegmented){
        self.titleView = [[ljwcodePageSegmentedTitleView alloc]initWithConfig:config];
    }
    
    self.titleView.dataSource = self;
    self.titleView.delegate = self;
    [self.contentView addSubview:self.titleView];
    
    self.pageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    [self.contentView addSubview:self.pageVC.view];
    [self addChildViewController:self.pageVC];
    
    for(UIScrollView *scrollView in self.pageVC.view.subviews){
        if([scrollView isKindOfClass:[UIScrollView class]]){
            self.scrollView = scrollView;
            self.scrollView.delegate = self;
        }
    }
    
    self.scrollEnable = true;
    self.bounces = true;
    self.lastDelegateIndex = -1;
    
    self.scrollView.gestureRecBlock = ^BOOL(UIGestureRecognizer * _Nonnull gestureRec) {
        return weakSelf.selectIndex == 0 && [weakSelf.otherGestureDelegateClassArray containsObject:NSStringFromClass(gestureRec.delegate.class)];
    };
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.contentView.frame = self.view.bounds;
    self.titleView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.config.titleViewHeight);
    
    self.pageVC.view.frame = CGRectMake(0, self.config.titleViewHeight, self.contentView.bounds.size.width, self.contentView.bounds.size.height - self.config.titleViewHeight);
     
    if(self.config.showTitleViewInNavigationBar){
        self.pageVC.view.frame = self.contentView.bounds;
    }
    
    if(!self.isDidLoadVC){
        [self switchToViewControllerAtIndex:_selectIndex animated:NO];
        self.isDidLoadVC = true;
    }
    self.titleArray = [[NSMutableArray alloc]init];
    for(NSInteger i = 0;i < [self numberOfPage];i++){
        [self.titleArray addObject:[self titleForIndex:i]];
    }
}

#pragma mark ---- UIPageViewControllerDelegate && UIPageViewControllerDataSource

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    self.isAnimaitonVC = YES;
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(!completed){
        self.isAnimaitonVC = NO;
        return;
    }
    UIViewController *vc = self.pageVC.viewControllers.firstObject;
    _selectIndex = [self.titleArray indexOfObject:vc.vc_title];
    self.titleView.selectedIndex = _selectIndex;
    
    [self delegateSelectedAtIndex:_selectIndex];
    self.isAnimaitonVC = NO;
    
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    [self fixSelectedIndexWhenDragingBefore];
    return  [self viewControllerForIndex:_selectIndex - 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    [self fixSelectedIndexWhenDragingAfter];
    return [self viewControllerForIndex:_selectIndex + 1];
}

-(void)initWithData{
    self.showVCArray = [[NSMutableArray alloc]init];
}

#pragma mark ----- Pirvate method

-(void)fixSelectedIndexWhenDragingBefore {
    CGFloat dragDistance = fabs(self.scrollView.contentOffset.x - self.dragStartX);
    
    if(self.scrollView.isTracking && dragDistance > self.scrollView.bounds.size.width){
        self.isAnimaitonVC = NO;
        NSInteger targetIndex = _selectIndex - 1;
        targetIndex = targetIndex < 0 ? 0 : targetIndex;
        self.selectIndex = targetIndex;
        self.titleView.stopAnimation = NO;
        
    }
}

-(void)fixSelectedIndexWhenDragingAfter {
    CGFloat dragDistance = fabs(self.scrollView.contentOffset.x - self.dragStartX);
    if(self.scrollView.isTracking && dragDistance > self.scrollView.bounds.size.width) {
        self.isAnimaitonVC = NO;
        NSInteger targetIndex = _selectIndex + 1;
        targetIndex = targetIndex >= [self numberOfPage] ? [self numberOfPage] - 1 : targetIndex;
        self.selectIndex = targetIndex;
        self.titleView.stopAnimation = NO;
        [self delegateSelectedAtIndex:targetIndex];
    }
}

-(UIViewController *)viewControllerForIndex:(NSInteger)index {
    if(index < 0 || index >= [self numberOfPage]){
        return nil;
    }
    
    UIViewController *currentVC = self.pageVC.viewControllers.firstObject;
    NSString *currentTitle = currentVC.vc_title;
    NSString *targetTitle = [self titleForIndex:index];
    
    if([currentTitle isEqualToString:targetTitle]){
        return currentVC;
    }
    
    for(UIViewController *vc in self.showVCArray){
        if([vc.vc_title isEqualToString:targetTitle]){
            return vc;
        }
    }
    
    UIViewController *vc = [self.dataSource pageViewController:self viewControllerAtIndex:index];
    vc.vc_title = [self titleForIndex:index];
    vc.title = [self titleForIndex:index];
    
    [self.showVCArray addObject:vc];
    [self addChildViewController:vc];
    
    return vc;
}

-(NSString *)titleForIndex:(NSInteger)index {
    return [self.dataSource pageViewController:self titleAtIndex:index];
}

-(NSInteger)numberOfPage{
    return [self.dataSource pageViewControllerNumberOfPage];
}

-(void)delegateSelectedAtIndex:(NSInteger)index {
    if(index == self.lastDelegateIndex) {
        return;
    }
    self.lastDelegateIndex = index;
    if([self.delegate respondsToSelector:@selector(pageViewController:didSelectedIndex:)]){
        [self.delegate pageViewController:self didSelectedIndex:index];
    }
}
 
-(BOOL)switchToViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    if([self numberOfPage] == 0){
        return false;
        
    }
    if(self.isAnimaitonVC && self.config.titleViewStyle == ljwcodeTitleViewStyleBasic){
        return false;
    }
    if(index == _selectIndex && index >= 0 && self.isDidLoadVC){
        return false;
    }
    self.isAnimaitonVC = animated;
    _selectIndex = index;
    
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    if(_titleView.lastSelectedIndex > _selectIndex){
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.pageVC setViewControllers:@[[self viewControllerForIndex:index]] direction:direction animated:NO completion:^(BOOL finished) {
        weakSelf.isAnimaitonVC = NO;
    }];
    
    self.view.userInteractionEnabled = NO;
    float delayTime = animated ? viewControllerMethodDelay : 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakSelf.view.userInteractionEnabled = YES;
    });
    
    self.titleView.userInteractionEnabled = YES;
    return YES;
    
}

-(void)reloadData{
    self.isDidLoadVC = NO;
    [self.titleView reloadData];
    [self.titleArray removeAllObjects];
    for(NSInteger i = 0;i < [self numberOfPage];i++){
        [self.titleArray addObject:[self titleForIndex:i]];
    }
}

#pragma mark ---- UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat value = scrollView.contentOffset.x - scrollView.bounds.size.width;
    self.titleView.animationProgress = value / scrollView.bounds.size.width;
    if(self.otherGestureDelegateClassArray.count > 0){
        BOOL scrollDisabled = value < 0 && self.selectIndex == 0 && self.otherGestureDelegateClassArray.count;
        scrollView.scrollEnabled = !scrollDisabled;
    }
    
    BOOL dragToTheEdge = (self.selectIndex == 0 && value < 0) || (self.selectIndex == [self numberOfPage] - 1 && value > 0);
    if(dragToTheEdge && scrollView.isDragging && self.bounces){
        scrollView.scrollEnabled = NO;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.titleView.stopAnimation = false;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.titleView.stopAnimation = false;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.titleView.stopAnimation = false;
    self.dragStartX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.titleView.stopAnimation = false;
    scrollView.scrollEnabled = self.scrollEnable;
}

#pragma mark ------- ljwcodePageBasicTitleViewDelegate && ljwcodePageBasicTitleViewDatasource

-(NSInteger)pageTitleViewNumberOfTitle{
    return [self numberOfPage];;
}

-(NSString *)pageTitleViewTitleAtIndex:(NSInteger)index{
    return  [self titleForIndex:index];
}

-(ljwcodePageTitleCollectionViewCell *)pageTitleViewCellForItemAtIndex:(NSInteger)index {
    if([self.dataSource respondsToSelector:@selector(pageViewCOntroller:titleViewCellForItemAtIndex:)]){
        return [self.dataSource pageViewCOntroller:self titleViewCellForItemAtIndex:index];
    }
    return nil;
}

-(BOOL)pageTitleViewDidSelectedAtIndex:(NSInteger)index{
    BOOL switchSuccess = [self switchToViewControllerAtIndex:index animated:YES];
    if(!switchSuccess){
        return false;
    }
    self.titleView.stopAnimation = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(viewControllerMethodDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self delegateSelectedAtIndex:index];
    });
    return true;
}

#pragma mark ------ setter && getter

-(void)setSelectIndex:(NSInteger)selectIndex {
    if(selectIndex < 0 || selectIndex > [self numberOfPage]){
        [NSException raise:@"selectedIndex is not right" format:@"It is out of range"];
    }
    
    BOOL switchSuccess = [self switchToViewControllerAtIndex:self.selectIndex animated:YES];
    if(!switchSuccess){
        return;
    }
    self.titleView.stopAnimation = true;
    self.lastDelegateIndex = selectIndex;
}


-(void)setScrollEnable:(BOOL)scrollEnable {
    _scrollEnable = scrollEnable;
    self.scrollView.scrollEnabled = scrollEnable;
}

-(void)setRightBtn:(UIButton *)rightBtn {
    _titleView.rightBtn = rightBtn;
}

-(void)registerClasss:(Class)cellClass registerTitleViewCellWithResuseIdentifier:(NSString *)identifier {
    [self.titleView registerClass:cellClass cellForTitleWithResuseIdentifier:identifier];
}

-(ljwcodePageTitleCollectionViewCell *)dequeueReusableTitleViewCellWithIdentifier:(NSString *)identifier forIndex:(NSInteger)index {
    return [self.titleView dequeueResuseIdentifier:identifier forIndex:index];
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

@implementation ljwcodePageView



@end
