//
//  TTSearchViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/16.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTSearchViewController;

typedef void(^didSearchBlock)(TTSearchViewController *searchController,UISearchBar *searchBar,NSString *searchText);

@interface TTSearchViewController : UIViewController

@property(nonatomic,assign)CGFloat hotSearchStyle;

@property(nonatomic,strong)NSArray *keywordArray;

+(instancetype)searchViewControllerWithHotSearchies:(NSArray<NSString *>*)hotSearchies searchControllerPlaceHolder:(NSString *)placeHolder searchBlock:(didSearchBlock)searchBlock;

@end

NS_ASSUME_NONNULL_END
