//
//  homeTitleViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/6/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "homeTitleViewModel.h"
#import "homeTitleModel.h"
#import "homeTitleRequestModel.h"

@implementation homeTitleViewModel

-(instancetype)init{
    if(self = [super init]){
        _titleCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                homeTitleRequestModel *request = [homeTitleRequestModel initWithNetworkModelWithUrlString:TTNetworkURLManager.homeTitleUrlString isPost:NO];
                request.iid = LJWCODE_IID;
                request.device_id = LJWCODE_DEVICE_ID;
                request.aid = [input intValue];
                [request sendRequestWithSuccess:^(id response) {
                    
                    NSDictionary *responseDic = (NSDictionary *)response;
                    responseDic = responseDic[@"data"];
                    NSMutableArray *models = [NSMutableArray array];
                    if (responseDic.count > 0) {
                        NSString *raccomand = @"{\"category\": \"recommend\", \"name\": \"推荐\"}";
                        NSArray *dicArr = [[NSArray alloc]init];
                        dicArr = responseDic[@"data"];
                        NSMutableArray *array = [[NSMutableArray alloc]init];
                        [array addObject:raccomand];

                        [array addObjectsFromArray:dicArr];

                        for (int i = 0; i < [array count]; i++) {
                            homeTitleModel *model = [[homeTitleModel new] mj_setKeyValues:array[i]];
                            [models addObject:model];
                        }
                        [subscriber sendNext:models];
                        [subscriber sendCompleted];
                        
                    }else {
                        [MBProgressHUD showError: server_error toView:nil];
                    }
                } failHandle:^(NSError *error) {
                    [MBProgressHUD showSuccess:@"网络请求失败"];
                }];
                return nil;
            }];
        }];
    }
    return self;
}

@end
