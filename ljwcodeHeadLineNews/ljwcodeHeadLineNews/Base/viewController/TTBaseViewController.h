//
//  TTBaseViewController.h
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2020/6/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TTBaseViewControllerDelegate<NSObject>

@optional
-(void)needRefreshTableViewData;

-(void)rightItemAction;

@end

@interface TTBaseViewController : UIViewController<TTBaseViewControllerDelegate>


@end

NS_ASSUME_NONNULL_END
