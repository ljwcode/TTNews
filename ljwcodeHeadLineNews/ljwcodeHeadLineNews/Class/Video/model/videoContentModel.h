//
//  videoContentModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface videoUserInfoModel : NSObject

@property(nonatomic,copy)NSString *avatar_url;

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

@property(nonatomic,strong)videoUserInfoModel *userInfoModel;

@end

@interface videoContentModel : NSObject

@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)BOOL playing;

@property(nonatomic,strong)videoDetailModel *detailModel;

@end

NS_ASSUME_NONNULL_END
