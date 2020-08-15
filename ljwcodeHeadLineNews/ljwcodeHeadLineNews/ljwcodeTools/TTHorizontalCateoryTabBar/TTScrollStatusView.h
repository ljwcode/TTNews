//
//  TTScrollStatusView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,ScrollTapType)
{
    ScrollTapTypeWithNavigation,
    ScrollTapTypeWithNavigationAndTabbar,
    ScrollTapTypeWithNothing,
};

@protocol TTScrollStatusDelegate<UITableViewDelegate,UITableViewDataSource>

-(void)refreshViewWithTag:(NSInteger)tag isHeader:(BOOL)isHeader;

@end

@interface TTScrollStatusView : UIView

@property(nonatomic,strong)NSMutableArray *viewArr;

@property(nonatomic,weak)id<TTScrollStatusDelegate> scrollStatusDelegate;

- (instancetype)initWithTitleArr:(NSArray *)titleArr
                            type:(ScrollTapType)type;

- (instancetype)initWithTitleArr:(NSArray *)titleArr
                            type:(ScrollTapType)type
                  normalTabColor:(UIColor *)normalTabColor
                  selectTabColor:(UIColor *)selectTabColor
                       lineColor:(UIColor *)lineColor;

@end

NS_ASSUME_NONNULL_END
