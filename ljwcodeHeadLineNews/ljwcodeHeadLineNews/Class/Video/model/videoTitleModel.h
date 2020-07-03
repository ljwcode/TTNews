//
//  videoTitleModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface videoTitleModel : NSObject

/*
 category = "subv_tt_video_sports";
 "category_type" = 0;
 flags = 0;
 "icon_url" = "";
 name = "\U4f53\U80b2";
 "tip_new" = 0;
 type = 4;
 "web_url" = "";
 */

@property(nonatomic,copy)NSString *category;

@property(nonatomic,assign)int category_type;

@property(nonatomic,assign)int flags;

@property(nonatomic,copy)NSString *icon_url;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)int tip_new;

@property(nonatomic,assign)int type;

@property(nonatomic,copy)NSString *web_url;



@end

NS_ASSUME_NONNULL_END
