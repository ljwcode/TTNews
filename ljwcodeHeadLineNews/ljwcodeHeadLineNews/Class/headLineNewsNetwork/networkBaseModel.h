//
//  networkBaseModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "networkURLManager.h"
#import "networkManagerCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface networkBaseModel : NSObject

@property(nonatomic,assign)BOOL isPost;
@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,strong)NSMutableDictionary *parameter;

@property(nonatomic,assign)BOOL showErrorHud;

+(instancetype)initWithNetworkModelWithUrlString:(NSString *)urlString isPost:(BOOL)isPost;

-(void)sendRequestWithSuccess:(requestSucceedHandle)successHandle failHandle:(requestFailHandle)failHandle;

@end

NS_ASSUME_NONNULL_END
