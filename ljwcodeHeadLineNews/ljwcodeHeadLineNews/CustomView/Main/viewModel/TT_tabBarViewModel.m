//
//  TT_tabBarViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_tabBarViewModel.h"
#import "TT_tabBarModel.h"
#import <MJExtension/MJExtension.h>

@interface TT_tabBarViewModel()


@end

@implementation TT_tabBarViewModel

-(instancetype)init{
    if(self = [super init]){
        _tabBarCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"TTTabBarModel" ofType:@"json"];
                NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
                NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
                
                NSArray *dataArray = [jsonDic objectForKey:@"data"];
                NSMutableArray *modelArray = [[NSMutableArray alloc]init];
                for(int i = 0; i < dataArray.count;i++){
                    TT_tabBarModel *model = [[[TT_tabBarModel alloc]init]mj_setKeyValues:dataArray[i]];
                    [modelArray addObject:model];
                }
                [subscriber sendNext:modelArray];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return self;
}

@end
