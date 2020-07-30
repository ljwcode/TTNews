//
//  headLineSearchViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class headLineSearchViewController;

typedef void(^didSearchBlock)(headLineSearchViewController *searchController,UISearchBar *searchBar,NSString *searchText);

@interface headLineSearchViewController : UIViewController

@property(nonatomic,assign)CGFloat hotSearchStyle;

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *>*)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder;

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *>*)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock;

@end

NS_ASSUME_NONNULL_END
