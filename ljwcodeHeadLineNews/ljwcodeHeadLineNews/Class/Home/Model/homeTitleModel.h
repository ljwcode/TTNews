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
