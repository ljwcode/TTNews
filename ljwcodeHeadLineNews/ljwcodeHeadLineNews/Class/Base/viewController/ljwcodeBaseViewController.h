//
//  ljwcodeBaseViewController.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ljwcodeHeader.h"
#import "ljwcodeNavigationBar.h"
#import <YYCache/YYCache.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ljwcodeBaseViewControllerDelegate<NSObject>

@optional
-(void)needRefreshTableViewData;
-(void)rightItemAction;

@end

@interface ljwcodeBaseViewController : UIViewController<ljwcodeBaseViewControllerDelegate>

-(ljwcodeNavigationBar *)showNaviBar;


@end

NS_ASSUME_NONNULL_END
