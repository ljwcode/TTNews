//
//  homeArticleContentViewModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/3/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "homeArticleContentViewModel.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import "TTNetworkURLManager.h"
#import "MBProgressHUD+Add.h"
#import "homeArticleContentModel.h"

@interface homeArticleContentViewModel()

@property(nonatomic,strong)homeArticleContentModel *model;

@end

@implementation homeArticleContentViewModel

-(instancetype)init{
    if(self = [super init]){
        _ArticleContentCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager GET:[TTNetworkURLManager TT_articleContentURL:input] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSDictionary *responseDic = (NSDictionary *)responseObject;
                    responseDic = [responseDic objectForKey:@"data"];
                    self.model = [[[homeArticleContentModel alloc]init]mj_setKeyValues:responseDic];
                    [subscriber sendNext:self.model];
                    [subscriber sendCompleted];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [MBProgressHUD showSuccess:@"网络请求失败"];
                }];
                return nil;
            }];
        }];
    }
    return self;
}

-(NSString *)TT_getHTMLString{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendString:@"<meta charset=\"UTF-8\">"];
    [html appendString:@"<meta name=\"viewport\" content=\"initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no\">"];
    [html appendString:@"<script>"];
    [html appendString:@"(function(i,s,o,g,r,a,m){i[\"SlardarMonitorObject\"]=r;i[r]=i[r]||function(){(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date;a=s.createElement(o),m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;a.crossOrigin='anonymous';m.parentNode.insertBefore(a,m);i[r].globalPreCollectError = function () {i[r]('precollect', 'error', arguments);};if (typeof i.addEventListener === 'function') {i.addEventListener('error', i[r].globalPreCollectError, true)}})(window,document,\"script\",\"https://i.snssdk.com/slardar/sdk.js?bid=article_app\",\"Slardar\");"];
    [html appendString:@"</script>"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"assets/TTArticleContent" ofType:@"css"];
    [html appendFormat:@"<link rel=\"stylesheet\" type=\"text/css\" href=\"%@\">",path];

    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:[self TT_getBodyString]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return html;
}

-(NSString *)TT_getBodyString{
    return self.model.content;
}

@end
