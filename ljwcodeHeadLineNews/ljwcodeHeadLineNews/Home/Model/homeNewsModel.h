//
//  homeNewsModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "videoContentModel.h"

NS_ASSUME_NONNULL_BEGIN

@class filter_words,url_list;

/*
 \"user\":{\"avatar_url\":\"http://p26.toutiaoimg.com/img/mosaic-legacy/363f000a0f2805b145d5~tplv-crop-center:120:120.webp?from=post\",\"desc\":\"《我是歌手》巅峰会主持人，参与《我们来了》《真正男子汉》等节目录制 影视代表作《妻子的谎言》《新龙门客栈》 \",\"id\":66211439052,\"is_blocked\":0,\"is_blocking\":0,\"is_followed\":0,\"is_following\":0,\"is_friend\":0,\"live_info_type\":0,\"medals\":[],\"name\":\"沈梦辰\",\"remark_name\":\"主持人 演员 \",\"schema\":\"sslocal://profile?uid=66211439052\\u0026refer=post\",\"screen_name\":\"沈梦辰\",\"theme_day\":\"\",\"user_auth_info\":\"{\\\"auth_type\\\":\\\"1\\\",\\\"auth_info\\\":\\\"主持人 演员 \\\"}\",\"user_decoration\":\"\",\"user_id\":66211439052,\"user_verified\":1,\"verified_content\":\"主持人 演员 \"},
 */

@interface microToutiaoUserInfo : NSObject

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,copy)NSString *desc;

@property(nonatomic,copy)NSString *microToutiaoUserID;

@property(nonatomic,assign)int is_blocking;

@property(nonatomic,assign)int is_followed;

@property(nonatomic,assign)int is_friend;

@property(nonatomic,assign)int live_info_type;

@property(nonatomic,copy)NSString *medals;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *remark_name;

@property(nonatomic,copy)NSString *schema;

@property(nonatomic,copy)NSString *screen_name;

@property(nonatomic,copy)NSString *theme_day;

@property(nonatomic,copy)NSString *user_auth_info;

@property(nonatomic,assign)int auth_type;

@property(nonatomic,copy)NSString *auth_info;

@property(nonatomic,copy)NSString *user_decoration;

@property(nonatomic,copy)NSString *user_id;

@property(nonatomic,assign)int user_verified;

@property(nonatomic,copy)NSString *verified_content;

@end

@interface detail_cover_list : NSObject

@property(nonatomic,assign)int height;

@property(nonatomic,assign)int type;

@property(nonatomic,copy)NSString *uri;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,strong)url_list *url_list;

@property(nonatomic,assign)int width;

@end

@interface dataArray : NSObject

@property(nonatomic,strong)filter_words *filter_words;

@end

@interface large_image_list : NSObject

@property(nonatomic,copy)NSString *url;

@end


@interface filter_words : NSObject

@property(nonatomic,copy)NSString *name;

@end

@interface homeNewsImageModel : NSObject

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

@end

@interface url_list : NSObject

@property(nonatomic,copy)NSString *url;

@end

@interface animated_cover_image_list : NSObject

@property(nonatomic,strong)url_list *url_list;

@end

@interface raw_data : NSObject

@property(nonatomic,strong)animated_cover_image_list *animated_list_image_list;

@end


@interface superDataArray : NSObject


@end

@interface tips : NSObject

@property(nonatomic,copy)NSString *app_name;

@end

@interface shortVideoArray : NSObject

@property(nonatomic,strong)raw_data *raw_data;

@property(nonatomic,strong)animated_cover_image_list *animated_cover_image_list;

@end

@interface microVideoInfoModel : NSObject

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *card_title;

@end

@interface microVideoDetailModel : NSObject

@property(nonatomic,strong)microVideoInfoModel *microInfoModel;

@property(nonatomic,copy)NSString *content;


@end


@interface homeNewsMicroVideoModel : NSObject

@property(nonatomic,copy)NSString *message;

@property(nonatomic,strong)tips *tips;

@property(nonatomic,strong)NSArray *data;


@end

/*
 api接口和json转字典模型
 */
@interface homeNewsModel : NSObject

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)NSString *post_content_hint;

@property(nonatomic,assign)int total_number;


@end

@interface action_list : NSObject


@property(nonatomic,assign)int action;

@property(nonatomic,copy)NSString *desc;

@property(nonatomic,copy)NSString *extra;

@end

@interface homeNewsInfoModel : NSObject

@property(nonatomic,assign)NSTimeInterval publish_time;

@property(nonatomic,copy)NSString *abstract; //文章摘要

@property(nonatomic,copy)NSString *media_name;

@property(nonatomic,copy)NSString *display_url;

@property(nonatomic,strong)NSArray *image_list;

@property(nonatomic,copy)NSString *verified_content;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *keywords;

@property(nonatomic,copy)NSString *article_url;

@property(nonatomic,assign)int cell_type;

@property(nonatomic,assign)int read_count;

@property(nonatomic,copy)NSString *comment_count;

@property(nonatomic,strong)homeNewsImageModel *middle_image;

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,strong)filter_words *filterWords;

@property(nonatomic,copy)NSString *item_id;

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,assign)BOOL has_video;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@property(nonatomic,assign)int video_duration;

@property(nonatomic,copy)NSString *card_title;

@property(nonatomic,copy)NSString *stick_label;

@property(nonatomic,copy)NSString *label;

@property(nonatomic,copy)NSString *sub_title;

@property(nonatomic,copy)NSString *cell_flag;

@property(nonatomic,strong)NSArray<detail_cover_list *> *detail_cover_list;

@property(nonatomic,strong)NSArray *action_list;

@property(nonatomic,strong)microToutiaoUserInfo *user;

@property(nonatomic,copy)NSString *rich_content;

@property(nonatomic,copy)NSString *share_count;

@property(nonatomic,copy)NSString *digg_count;

@end

@interface homeNewsSummaryModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,strong)homeNewsInfoModel *infoModel;

@end



NS_ASSUME_NONNULL_END
