//
//  TT_VideoDetailModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "videoContentModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface user_info : NSObject

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,copy)NSString *fans_count;

@property(nonatomic,copy)NSString *follow;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)int user_id;


@end

@interface tt_xg_anchor : NSObject

@end

@interface activity : NSObject

@end

@interface share_info : NSObject

@property(nonatomic,copy)NSString *title;

@end

@interface related_video_toutiao : NSObject

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)int video_duration;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@end

@interface TT_VideoDetailModel : NSObject

@property(nonatomic,strong)user_info *user_info;

@property(nonatomic,copy)NSString *video_watch_count;

@property(nonatomic,strong)share_info *share_info;

@property(nonatomic,strong)related_video_toutiao *related_video_toutiao;

@property(nonatomic,strong)NSData *data;

@end

NS_ASSUME_NONNULL_END
