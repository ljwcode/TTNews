//
//  newsDetailModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/5.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "newsDetailModel.h"
#import <MJExtension/MJExtension.h>

@implementation newsAuthorInfoModel

@end

@implementation NewsInfoModel

@end

@implementation NewsImageModel

@end

@implementation newsDetailModel

-(NewsInfoModel *)infoModel{
    if(!_infoModel){
        NSData *data = [self.content dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NewsInfoModel *model = [[NewsInfoModel alloc]init];
        [model mj_setKeyValues:dic];
        _infoModel = model;
    }
    return _infoModel;
}

@end
