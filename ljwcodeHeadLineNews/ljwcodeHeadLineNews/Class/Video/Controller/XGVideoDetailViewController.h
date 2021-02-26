//
//  XGVideoDetailViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
#import "videoContentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TT_VideoDetailBlock) (NSString *videoURL);

@interface XGVideoDetailViewController : TTBaseViewController

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,strong)videoContentModel *contentModel;

@property(nonatomic,copy)TT_VideoDetailBlock VideoDetailBlock;

@end

NS_ASSUME_NONNULL_END
