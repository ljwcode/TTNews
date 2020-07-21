//
//  shortVideoPlayerViewCell.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/10.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "videoContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface shortVideoPlayerViewCell : UITableViewCell

@property(nonatomic,strong)videoContentModel *contentModel;

@property(nonatomic,copy)void(^imgViewCallBack)(UIView *parentView);

@end

NS_ASSUME_NONNULL_END
