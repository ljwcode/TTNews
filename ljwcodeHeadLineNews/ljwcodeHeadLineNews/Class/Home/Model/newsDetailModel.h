//
//  newsDetailModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/5.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface newsAuthorInfoModel : NSObject

@property(nonatomic,copy)NSString *avatar_url; //作者头像

@property(nonatomic,copy)NSString *name; //作者姓名


@end

@interface NewsImageModel : NSObject

@property(nonatomic,copy)NSString *type;

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

@end

@interface NewsInfoModel : NSObject

@property(nonatomic,copy)NSString *abstract;

@property(nonatomic,copy)NSString *media_name; //作者姓名

@property(nonatomic,copy)NSString *display_url;

@property(nonatomic,strong)NSArray *image_list;

@property(nonatomic,copy)NSString *verified_content; //作者简介

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *keywords;

@property(nonatomic,copy)NSString *article_url;

@property(nonatomic,assign)int cell_type;

@property(nonatomic,assign)int read_count;

@property(nonatomic,strong)NewsImageModel *middle_image;

@property(nonatomic,strong)newsAuthorInfoModel *authorInfo;


@end

@interface newsDetailModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,strong)NewsInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
