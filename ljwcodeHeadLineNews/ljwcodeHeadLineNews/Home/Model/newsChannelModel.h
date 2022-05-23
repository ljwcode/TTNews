//
//  newsChannelModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/28.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class channelButton;
@interface newsChannelModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)CGRect frame;

@property(nonatomic,assign)int tag;

@property(nonatomic,assign)BOOL isMyChannel;

@property(nonatomic,assign)BOOL hideDeleteBtn;

@property(nonatomic,strong)channelButton *Btn;

@end

NS_ASSUME_NONNULL_END
