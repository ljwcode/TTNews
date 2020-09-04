//
//  VideoDetailViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/15.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoTitleModel.h"
#import "TTBaseViewController.h"
#import "homeTitleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailViewController : TTBaseViewController

@property(nonatomic,strong)videoTitleModel *titleModel;

@property(nonatomic,strong)homeTitleModel *homeTitle;

@property(nonatomic,copy)void(^parseRealURL)(NSString *url);

@end

NS_ASSUME_NONNULL_END
