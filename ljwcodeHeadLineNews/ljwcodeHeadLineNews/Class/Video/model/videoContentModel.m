//
//  videoContentModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/7/3.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "videoContentModel.h"
#import <MJExtension/MJExtension.h>

@implementation MediaInfoModel

@end

@implementation videoUrlInfoModel

- (NSString *)main_url {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:_main_url options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}
- (NSString *)back_url_1 {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:_back_url_1 options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

@end
@implementation video_list


@end

@implementation videoDetailModel

@end

@implementation videoContentModel

-(BOOL)isIsVerticalVideo{
//    return _video_list.vwidth < _video_list.vheight;
    return NO;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _playing = NO;
    }
    return self;
}
- (videoDetailModel *)detailModel {
    if (!_detailModel) {
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _detailModel = [[[videoDetailModel alloc]init] mj_setKeyValues:dic];
    }
    return _detailModel;
}

-(video_list *)video_list{
    if(!_video_list){
        NSData *data = [self.data dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _video_list = [[[video_list alloc]init]mj_setKeyValues:dic];
    }
    return _video_list;
}

@end

@implementation video_detail_info

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

@end

