//
//  homeNewsModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/30.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 api接口和json转字典模型
 */
@interface homeNewsModel : NSObject

@property(nonatomic,strong)NSArray *data;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,copy)NSString *post_content_hint;

@property(nonatomic,assign)int total_number;


@end

/*
 \"filter_words\":[{\"id\":\"8:0\",\"name\":\"\U770b\U8fc7\U4e86\",\"is_selected\":false},{\"id\":\"9:1\",\"name\":\"\U5185\U5bb9\U592a\U6c34\",\"is_selected\":false},{\"id\":\"5:1247756413\",\"name\":\"\U62c9\U9ed1\U4f5c\U8005:\U65b0\U534e\U878d\U5a92\U65b0\U6d88\U8d39\",\"is_selected\":false},{\"id\":\"1:1641\",\"name\":\"\U4e0d\U60f3\U770b:\U65f6\U653f\",\"is_selected\":false},{\"id\":\"6:47749\",\"name\":\"\U4e0d\U60f3\U770b:\U5185\U8499\U53e4\",\"is_selected\":false}],
 */

@interface filter_words : NSObject

@property(nonatomic,copy)NSString *name;

@end

@interface homeNewsImageModel : NSObject

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

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

@property(nonatomic,strong)homeNewsImageModel *middle_image;

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,strong)filter_words *filterWords;

@end

@interface homeNewsSummaryModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,strong)homeNewsInfoModel *infoModel;

@end



NS_ASSUME_NONNULL_END
