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

@class filter_words;

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

@property(nonatomic,assign)int comment_count;

@property(nonatomic,strong)homeNewsImageModel *middle_image;

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,strong)filter_words *filterWords;

@property(nonatomic,copy)NSString *item_id;

@property(nonatomic,copy)NSString *group_id;

@property(nonatomic,assign)BOOL has_video;

@property(nonatomic,strong)video_detail_info *video_detail_info;

@property(nonatomic,assign)int video_duration;

@property(nonatomic,copy)NSString *card_title;

@end

@interface homeNewsSummaryModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,strong)homeNewsInfoModel *infoModel;

@end



NS_ASSUME_NONNULL_END
