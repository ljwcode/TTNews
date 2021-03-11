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
#import "RegexKitLite.h"
#import "TT_NewsContentImgModel.h"

@interface homeArticleContentViewModel()

@property(nonatomic,strong)homeArticleContentModel *ContentModel;

@property(nonatomic,strong)TT_NewsContentImgModel *imgModel;

@property(nonatomic,strong)NSMutableArray *imgModelArray;

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
                    self.ContentModel = [[[homeArticleContentModel alloc]init]mj_setKeyValues:responseDic];
                    
                    NSArray *imgArray = [[responseDic objectForKey:@"image_batch_info"]objectForKey:@"image_detail"];
                    for(int i = 0;i < imgArray.count;i++){
                        self.imgModel = [[[TT_NewsContentImgModel alloc]init]mj_setKeyValues:imgArray[i]];
                        [self.imgModelArray addObject:self.imgModel];
                    }
                    [subscriber sendNext:self.ContentModel];
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


-(NSArray *)getHtmlImgURL:(NSString *)html{
    NSString *regex = @"<[a] class=\"image\"+.*?>([\\s\\S]*?)</[a]*?>";
    NSArray *array = [html arrayOfCaptureComponentsMatchedByRegex:regex];
    return array;
}

- (NSString *)TT_getBodyString{
    NSMutableString *body = [NSMutableString stringWithString:self.ContentModel.content];
    NSArray *imgPositionArray = [self getHtmlImgURL:self.ContentModel.content];
    for (int i = 0;i < self.imgModelArray.count;i++) {
        TT_NewsContentImgModel *model = self.imgModelArray[i];
        NSMutableString *imgHtml = [NSMutableString string];
        CGFloat width = model.width;
        CGFloat height = model.height;
        
        CGFloat maxWidth = kScreenWidth * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        [imgHtml appendFormat:@"<img class = \"image\" width=\"%f\" height=\"%f\" src=\"%@\">",width,height,model.url];
        [body replaceOccurrencesOfString:imgPositionArray[i][0] withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

#pragma mark ---- lazy load

-(NSMutableArray *)imgModelArray{
    if(!_imgModelArray){
        _imgModelArray = [[NSMutableArray alloc]init];
    }
    return _imgModelArray;
}

@end
