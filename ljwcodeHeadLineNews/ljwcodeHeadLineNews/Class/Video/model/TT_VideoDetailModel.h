//
//  TT_VideoDetailModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/19.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface user_info : NSObject
/*
 {
     "avatar_url" = "http://p6.toutiaoimg.com/img/pgc-image/ca307d5b4b784405b2139c435d0cbb26~tplv-resize:120:120.webp?from=xigua";
     "fans_count" = 45109;
     follow = 0;
     "live_business_type" = 0;
     "live_info_type" = 1;
     name = "\U793e\U4f1a\U4e00\U7ebf\U7ad9";
     "room_schema" = "";
     schema = "sslocal://profile?uid=4186583865496695&refer=video";
     "sec_user_id" = "MS4wLjABAAAANKcpYLz3bG-P6wStn1PfHHAXgU_P0mlqqFmbUBJHWEEm-E3Wy5h5rS8QvjqdLTuQ";
     subcribed = 0;
     "user_auth_info" = "{\"auth_info\":\"\U300a\U793e\U4f1a\U4e00\U7ebf\U7ad9\U300b\U680f\U76ee\U5b98\U65b9\U8d26\U53f7\",\"auth_type\":\"0\"}";
     "user_decoration" = "";
     "user_id" = 4186583865496695;
     "user_verified" = 1;
 }
 */

@property(nonatomic,copy)NSString *avatar_url;

@property(nonatomic,copy)NSString *fans_count;

@property(nonatomic,copy)NSString *follow;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)int user_id;


@end

@interface detailInfoModel : NSObject

@property(nonatomic,strong)user_info *user_info;

@end

@interface TT_VideoDetailModel : NSObject

@property(nonatomic,strong)detailInfoModel *detailInfoModel;

@property(nonatomic,strong)NSData *data;

@property(nonatomic,strong)user_info *user_info;

@end

NS_ASSUME_NONNULL_END
