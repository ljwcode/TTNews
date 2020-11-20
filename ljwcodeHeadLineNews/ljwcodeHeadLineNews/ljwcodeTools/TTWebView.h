//
//  TTWebView.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/20.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTWebView;
@protocol TTWebViewDelegate <NSObject>
@optional

- (void)webViewDidStartLoad:(TTWebView *)webView;
- (void)webViewDidFinishLoad:(TTWebView *)webView;
- (void)webView:(TTWebView *)webView didFailLoadWithError:(NSError *)error;
- (BOOL)webView:(TTWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

@end

@interface TTWebView : UIView

@property(weak,nonatomic)id<TTWebViewDelegate> delegate;

///内部使用的webView
@property (nonatomic, readonly) id realWebView;

///预估网页加载进度
@property (nonatomic, readonly) double estimatedProgress;

@property (nonatomic, readonly) NSURLRequest *originRequest;

- (NSInteger)countOfHistory;
- (void)gobackWithStep:(NSInteger)step;

@property (nonatomic, readonly) UIScrollView *scrollView;

- (id)loadRequest:(NSURLRequest *)request;
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSURLRequest *currentRequest;
@property (nonatomic, readonly) NSURL *URL;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;
@property (nonatomic, readonly) BOOL canGoBack;
@property (nonatomic, readonly) BOOL canGoForward;

- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler;

///是否根据视图大小来缩放页面  默认为YES
@property (nonatomic) BOOL scalesPageToFit;

@end

