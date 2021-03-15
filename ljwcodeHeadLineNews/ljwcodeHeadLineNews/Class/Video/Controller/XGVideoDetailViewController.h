//
//  XGVideoDetailViewController.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/29.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TT_VideoDetailBlock) (NSString *videoURL);

@interface XGVideoDetailViewController : UIViewController

@property(nonatomic,copy)NSString *videoURL;

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,copy)TT_VideoDetailBlock VideoDetailBlock;

@end

NS_ASSUME_NONNULL_END
