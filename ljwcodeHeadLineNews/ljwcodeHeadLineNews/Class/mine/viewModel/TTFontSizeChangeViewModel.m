//
//  TTFontSizeChangeViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/21.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTFontSizeChangeViewModel.h"
#import <MJExtension/MJExtension.h>

@implementation TTFontSizeChangeViewModel

-(TTFontSizeChangeModel *)TT_getFontSizeJSONModelWithKey:(NSString *)key{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"TTFontSizeChangeModel" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *responseDic = [jsonDic objectForKey:key];
    TTFontSizeChangeModel *model = [[[TTFontSizeChangeModel alloc]init]mj_setKeyValues:responseDic];
    
    return model;
    
}

@end
