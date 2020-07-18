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

@protocol headLineSearchViewControllerDelegate<NSObject>

-(void)backHandle:(headLineSearchViewController *)searchViewController;

-(void)cancelHandle:(headLineSearchViewController *)searchViewController;

-(void)searchViewController:(headLineSearchViewController *)searchViewController didSelectHotSearchAtIndex:(NSInteger)index searchAtIndexText:(NSString *)indexText;

-(void)searchViewController:(headLineSearchViewController *)searchViewController didSelectSearchHistoryAtIndex:(NSInteger)index searchAtIndexText:(NSString *)indexText;

-(void)searchViewController:(headLineSearchViewController *)searchViewController didSearchWithSearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText;

-(void)searchViewController:(headLineSearchViewController *)searchViewController searchTextDidChangeWithSearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText;

@end

@interface headLineSearchViewController : UIViewController

@property(nonatomic,assign)CGFloat hotSearchStyle;

@property(nonatomic,copy)id<headLineSearchViewControllerDelegate> delegte;

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *>*)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder;

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *>*)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock;

@end

NS_ASSUME_NONNULL_END
