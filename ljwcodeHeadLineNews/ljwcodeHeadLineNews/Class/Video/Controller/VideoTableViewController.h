//
//  VideoTableViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoTitleModel.h"
#import "TTBaseViewController.h"
#import "homeTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoTableViewController : TTBaseViewController

@property(nonatomic,strong)videoTitleModel *titleModel;

@property(nonatomic,strong)homeTitleModel *homeTitle;

@end

NS_ASSUME_NONNULL_END
