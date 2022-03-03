//
//  ljwcodePageSegmentedTitleView.m
//  ljwcodePageViewController
//
//  Created by ljwcode on 2021/10/21.
//

#import "ljwcodePageSegmentedTitleView.h"
#import "ljwcodePageViewControllerUtil.h"

@interface ljwcodePageSegmentedTitleView()

@property(nonatomic,strong)UISegmentedControl *segmentedControl;

@property(nonatomic,strong)ljwcodePageViewControllerConfig *config;

@property(nonatomic,strong)UIView *separetorLine;

@property(nonatomic,assign)BOOL haveLoadDataSource;

@end

@implementation ljwcodePageSegmentedTitleView

-(instancetype)initWithConfig:(ljwcodePageViewControllerConfig *)config {
    if(self = [super init]){
        [self initSegmentedWithConfig:config];
    }
    return self;
}

-(void)initSegmentedWithConfig:(ljwcodePageViewControllerConfig *)config {
    self.config = config;
    
    self.segmentedControl = [[UISegmentedControl alloc]init];
    [self.segmentedControl addTarget:self action:@selector(segmentedValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.tintColor = config.segmentedTintColor;
    [self addSubview:self.segmentedControl];
    
    self.separetorLine = [[UIView alloc]init];
    self.separetorLine.backgroundColor = config.separatorLineColor;
    self.separetorLine.hidden = config.showSeparatorLine;
    [self addSubview:self.separetorLine];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat segmentH = self.bounds.size.height - self.config.titleViewInsets.top - self.config.titleViewInsets.bottom;
    CGFloat segmentW = self.bounds.size.width - self.config.titleViewInsets.left - self.config.titleViewInsets.right;
    
    self.segmentedControl.frame = CGRectMake(self.config.titleViewInsets.left, self.config.titleViewInsets.top, segmentW, segmentH);
    self.separetorLine.frame = CGRectMake(0, self.bounds.size.height - self.config.separatorLineHeight, self.bounds.size.width, self.config.separatorLineHeight);
    
    if(!self.haveLoadDataSource){
        [self loadDataSource];
    }
    
}


-(void)loadDataSource {
    self.haveLoadDataSource = true;
    for(NSInteger i = 0;i < [self.dataSource pageTitleViewNumberOfTitle];i++){
        NSString *title = [self.dataSource pageTitleViewTitleAtIndex:i];
        [self.segmentedControl insertSegmentWithTitle:title atIndex:self.segmentedControl.numberOfSegments animated:false];
    }
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
}

-(void)reloadDarta {
    [self.segmentedControl removeAllSegments];
    for(NSInteger i = 0;i < [self.dataSource pageTitleViewNumberOfTitle];i++){
        NSString *title = [self.dataSource pageTitleViewTitleAtIndex:i];
        [self.segmentedControl insertSegmentWithTitle:title atIndex:self.segmentedControl.numberOfSegments animated:false];
    }
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
}

#pragma mark ------- click method

-(void)segmentedValueChanged:(UISegmentedControl *)segmentedControl{
    [self.delegate pageTitleViewDidSelectedAtIndex:segmentedControl.selectedSegmentIndex];
    self.lastSelectedIndex = segmentedControl.selectedSegmentIndex;
}


#pragma mark ----- setter && getter

-(void)setSelectedIndex:(NSInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    self.segmentedControl.selectedSegmentIndex = selectedIndex;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
