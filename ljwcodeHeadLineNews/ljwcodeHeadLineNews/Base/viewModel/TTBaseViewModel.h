//
//  TTBaseViewModel.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "TTNetworkURLManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseViewModel : NSObject

-(void)bindView:(UIView *)view;

-(void)bindTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
