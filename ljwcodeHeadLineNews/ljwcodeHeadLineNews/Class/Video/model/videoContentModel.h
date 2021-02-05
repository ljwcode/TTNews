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

/*
 \"pread_params\":\"{\\\"group_id\\\":6898974656468877838,\\\"item_id\\\":6898974656468877838,\\\"media_id\\\":1636917158242308,\\\"channel_id\\\":3431225546,\\\"category_tag\\\":\\\"video_movie\\\",\\\"from_category\\\":\\\"video\\\",\\\"is_gov_article\\\":false,\\\"display_flags\\\":0,\\\"review_comment_mode\\\":0,\\\"group_source\\\":2,\\\"categories\\\":[\\\"video_movie\\\"],\\\"video_duration\\\":1163,\\\"rec_quality\\\":0,\\\"title\\\":\\\"\U6b8a\U6b7b\Uff1a\U5973\U7279\U52a1\U5047\U626e\U6210\U8001\U4e5e\U4e10\Uff0c\U5c06\U72d9\U51fb\U67aa\U85cf\U5728\U7af9\U7aff\U91cc\Uff0c\U8c01\U77e5\U9ad8\U5174\U65e9\U4e86\\\"}\
 */

@interface pread_params : NSObject

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,assign)float item_id;

@property(nonatomic,assign)float media_id;

@property(nonatomic,assign)float channel_id;

@property(nonatomic,copy)NSString *category_tag;

@property(nonatomic,copy)NSString *from_category;

@property(nonatomic,assign)BOOL is_gov_article;

@property(nonatomic,assign)float display_flags;

@property(nonatomic,assign)float review_comment_mode;

@property(nonatomic,copy)NSString *categories;

@property(nonatomic,copy)NSString *title;

@end

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

@property(nonatomic,assign)int vwidth;

@property(nonatomic,assign)int vheight;

@end

@interface video_list : NSObject

@property(nonatomic,strong)videoUrlInfoModel *video_1;

@property(nonatomic,strong)videoUrlInfoModel *video_2;

@property(nonatomic,strong)videoUrlInfoModel *video_3;

@end

@interface detail_video_large_image : NSObject

@property(nonatomic,strong)NSString *url;

@end

@interface video_detail_info : NSObject

@property(nonatomic,assign)int group_flags;

@property(nonatomic,strong)detail_video_large_image *detail_video_large_image;

@property(nonatomic,copy)NSString *video_id;

@property(nonatomic,assign)int direct_play;

@property(nonatomic,assign)int show_pgc_subscribe;

@property(nonatomic,assign)int video_watch_count;

@property(nonatomic,assign)int video_type;

@property(nonatomic,assign)int video_watching_count;

@property(nonatomic,assign)int video_preloading_flag;

@end



@interface videoDetailModel : NSObject

@property(nonatomic,copy)NSString *comment_count;

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *video_play_info;

@property(nonatomic,strong)MediaInfoModel *media_info;

@property(nonatomic,copy)NSString *share_url;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@property(nonatomic,assign)int video_duration;

@property(nonatomic,strong)video_list *video_list;

@property(nonatomic,strong)pread_params *pread_params;

@end


@interface videoContentModel : NSObject

@property(nonatomic,assign)float video_duration;

@property(nonatomic,copy)NSString *poster_url;

@property(nonatomic,strong)video_list *video_list;

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,strong)videoDetailModel *detailModel;

@property(nonatomic,strong)pread_params *pread_params;


@end

NS_ASSUME_NONNULL_END
