//
//  videoContentModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface MediaInfoModel : NSObject

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,assign)int follow;

@property(nonatomic,copy)NSString *is_star_user;

@property(nonatomic,copy)NSString *media_id;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *recommend_reason;

@property(nonatomic,copy)NSString *recommend_type;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,copy)NSString *user_verified;

@property(nonatomic,copy)NSString *verified_content;

@end

@interface videoUrlInfoModel : NSObject

@property(nonatomic,copy)NSString *main_url;

@property(nonatomic,copy)NSString *back_url_1;

@end

@interface videoUrlLevelModel : NSObject

@property(nonatomic,strong)videoUrlInfoModel *video_1;

@property(nonatomic,strong)videoUrlInfoModel *video_2;

@property(nonatomic,strong)videoUrlInfoModel *video_3;

@end

@interface videoPlayInfoModel : NSObject

@property(nonatomic,assign)float video_duration;

@property(nonatomic,copy)NSString *poster_url;

@property(nonatomic,strong)videoUrlLevelModel *video_list;

@end

@interface videoDetailModel : NSObject

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *video_play_info;

@property(nonatomic,strong)videoPlayInfoModel *playInfoModel;

@property(nonatomic,strong)MediaInfoModel *userInfoModel;

@property(nonatomic,copy)NSString *share_url;

@property(nonatomic,strong)NSDictionary *media_info;

@end

@interface video_detail_info : NSObject

@property(nonatomic,assign)int group_flags;

@property(nonatomic,copy)NSString *detail_video_large_image;

@property(nonatomic,copy)NSString *video_id;

@property(nonatomic,assign)int direct_play;

@property(nonatomic,assign)int show_pgc_subscribe;

@property(nonatomic,assign)int video_watch_count;

@property(nonatomic,assign)int video_type;

@property(nonatomic,assign)int video_watching_count;

@property(nonatomic,assign)int video_preloading_flag;

@end

@interface videoContentModel : NSObject

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)BOOL playing;

@property(nonatomic,strong)videoDetailModel *detailModel;

@property(nonatomic,strong)video_detail_info *videoInfo;

@end



NS_ASSUME_NONNULL_END
