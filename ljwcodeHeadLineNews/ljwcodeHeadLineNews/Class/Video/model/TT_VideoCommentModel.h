//
//  TT_VideoCommentModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/23.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface comment : NSObject

@property(nonatomic,copy)NSString *text;

@property(nonatomic,copy)NSString *user_name;

@property(nonatomic,copy)NSString *digg_count;

@property(nonatomic,copy)NSString *user_profile_image_url;

@property(nonatomic,assign)NSTimeInterval create_time;

@property(nonatomic,copy)NSString *reply_count;

@end

@interface TT_VideoCommentModel : NSObject

@property(nonatomic,assign)int cell_type;

@property(nonatomic,assign)int id;

@property(nonatomic,strong)comment *comment;

@property(nonatomic,copy)NSString *total_number;


@end

NS_ASSUME_NONNULL_END
