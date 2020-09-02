//
//  homeTitleModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeTitleModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *category;

@property(nonatomic,copy)NSString *concern_id;

@property(nonatomic,assign)int flags;

@property(nonatomic,assign)int default_add;

@property(nonatomic,copy)NSString *icon_url;

@property(nonatomic,assign)int type;

@property(nonatomic,assign)int tip_new;


@end

NS_ASSUME_NONNULL_END
