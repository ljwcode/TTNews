//
//  homeJokeModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/1.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface homeJokeModel : NSObject

@property(nonatomic,strong)NSArray *data_array;

@property(nonatomic,copy)NSString *message;

@end

@interface homeJokeInfoModel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int comment_count;

@property(nonatomic,assign)int star_count;

@property(nonatomic,assign)int hate_count;


@end

@interface homeJokeSummarymodel : NSObject

@property(nonatomic,copy)NSString *content;

@property(nonatomic,assign)int code;

@property(nonatomic,assign)BOOL starBtnSelected;

@property(nonatomic,assign)BOOL hateBtnSelected;

@property(nonatomic,assign)BOOL collectionSelected;

@property(nonatomic,strong)homeJokeInfoModel *infoModel;

@end

NS_ASSUME_NONNULL_END
