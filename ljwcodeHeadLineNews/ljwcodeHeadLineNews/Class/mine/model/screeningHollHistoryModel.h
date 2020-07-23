//
//  screeningHollHistoryModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/23.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface videoDetailModel : NSObject

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *video_play_info;

@end

@interface screeningHollHistoryModel : NSObject

@property(nonatomic,readonly)NSString *video_bgImg;

@property(nonatomic,readonly)NSString *avatar_url;

@property(nonatomic,strong)videoDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
