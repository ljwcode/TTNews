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
@implementation videoUrlLevelModel


@end

@implementation videoPlayInfoModel


@end

@implementation videoDetailModel

- (videoPlayInfoModel *)playInfoModel {
    if (!_playInfoModel) {
        NSData *data = [self.video_play_info dataUsingEncoding:NSUTF8StringEncoding];
        if (!data) {
            return nil;
        }else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            _playInfoModel = [[[videoPlayInfoModel alloc]init] mj_setKeyValues:dic];
        }
    }
    return _playInfoModel;
}

@end

@implementation videoContentModel
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

-(video_detail_info *)videoInfo{
    if(!_videoInfo){
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        _videoInfo = [[[video_detail_info alloc]init]mj_setKeyValues:dic];
    }
    return _videoInfo;
}
@end

@implementation video_detail_info

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

@end

