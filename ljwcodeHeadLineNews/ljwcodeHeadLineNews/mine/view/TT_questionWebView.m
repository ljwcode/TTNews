//
//  TT_questionWebView.m
//  ljwcodeHeadLineNews
//
//  Created by ljwcode on 2021/7/13.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_questionWebView.h"
#import <WebKit/WebKit.h>
#import "TTNetworkURLManager.h"

@interface TT_questionWebView()<WKUIDelegate,WKNavigationDelegate>

@property(nonatomic,strong)WKWebView *questionWebView;


@end

@implementation TT_questionWebView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: [TTNetworkURLManager TT_loginQuestionURL]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:8.f];
        [self.questionWebView loadRequest:request];
        [self addSubview:self.questionWebView];

    }
    return self;
}


#pragma mark ------ lazy load

-(WKWebView *)questionWebView{
    if(!_questionWebView){
        WKWebView *questionWebView = [[WKWebView alloc]initWithFrame:self.bounds];
        questionWebView.UIDelegate = self;
        questionWebView.navigationDelegate = self;
        questionWebView.allowsBackForwardNavigationGestures = YES;
        questionWebView.backgroundColor = [UIColor yellowColor];
        _questionWebView = questionWebView;
        
    }
    return _questionWebView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
