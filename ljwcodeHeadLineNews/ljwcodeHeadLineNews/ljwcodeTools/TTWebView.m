//
//  TTWebView.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/11/20.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "TTWebView.h"
#import <WebKit/WebKit.h>

@interface TTWebView()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;

@property (nonatomic, copy) NSString *title;

@end

@implementation TTWebView

@synthesize realWebView = _realWebView;
@synthesize scalesPageToFit = _scalesPageToFit;

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WebViewFontSizeScale) name:TTWebViewFontSizeScale object:nil];
        [self initSelf];
    }
    return self;
}

-(void)initSelf{
    Class wkWebView = NSClassFromString(@"WKWebView");
    if(wkWebView){
        [self initWKWebView];
    }
    self.scalesPageToFit = YES;
    
    [self.realWebView setFrame:self.bounds];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
}
-(void)initWKWebView{
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    _realWebView = webView;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"estimatedProgress"]){
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
    }else if([keyPath isEqualToString:@"title"]){
        self.title = change[NSKeyValueChangeNewKey];
    }
}

#pragma mark- WKNavigationDelegate

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    webView.allowsBackForwardNavigationGestures = YES;
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    BOOL isLoadingDisableScheme = [self isLoadingWKWebViewDisableScheme:navigationAction.request.URL];
    
    if(resultBOOL && !isLoadingDisableScheme){
        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil){
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    webView.allowsBackForwardNavigationGestures = YES;
    [self callback_webViewDidStartLoad];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    [webView evaluateJavaScript:@"document.activeElement.blur();" completionHandler:nil];
    // 适当增大字体大小
    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%%'"];
    [webView evaluateJavaScript:js completionHandler:nil];
    webView.allowsBackForwardNavigationGestures = YES;
    [self callback_webViewDidFinishLoad];
}
- (void)webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error{
    [self callback_webViewDidFailLoadWithError:error];
}
- (void)webView: (WKWebView *)webView didFailNavigation:(WKNavigation *) navigation withError: (NSError *) error{
    [self callback_webViewDidFailLoadWithError:error];
}
#pragma mark- WKUIDelegate
///--  还没用到
#pragma mark- CALLBACK IMYVKWebView Delegate

- (void)callback_webViewDidFinishLoad{
    if([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]){
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)callback_webViewDidStartLoad{
    if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]){
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)callback_webViewDidFailLoadWithError:(NSError *)error{
    if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]){
        [self.delegate webView:self didFailLoadWithError:error];
    }
}
-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType{
    BOOL resultBOOL = YES;
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]){
        if(navigationType == -1) {
            navigationType = UIWebViewNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}

#pragma mark- 基础方法
///判断当前加载的url是否是WKWebView不能打开的协议类型
- (BOOL)isLoadingWKWebViewDisableScheme:(NSURL *)url{
    BOOL retValue = NO;
    //判断是否正在加载WKWebview不能识别的协议类型：phone numbers, email address, maps, etc.
    if([url.scheme isEqualToString:@"tel"]) {
        UIApplication *app = [UIApplication sharedApplication];
        if ([app canOpenURL:url]) {
            if(@available (iOS 10.0,*)){
                [app openURL:url options:@{} completionHandler:nil];
            }else{
                [app openURL:url];
            }
            retValue = YES;
        }
    }
    
    return retValue;
}

-(UIScrollView *)scrollView{
    return [(id)self.realWebView scrollView];
}

- (id)loadRequest:(NSURLRequest *)request{
    self.originRequest = request;
    self.currentRequest = request;
    return [(WKWebView*)self.realWebView loadRequest:request];
}
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL{
    return [(WKWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
}
-(NSURLRequest *)currentRequest{
    return _currentRequest;
}
-(NSURL *)URL{
    return [(WKWebView*)self.realWebView URL];
}
-(BOOL)isLoading{
    return [self.realWebView isLoading];
}
-(BOOL)canGoBack{
    return [self.realWebView canGoBack];
}
-(BOOL)canGoForward{
    return [self.realWebView canGoForward];
}

- (id)goBack{
    return [(WKWebView*)self.realWebView goBack];
}
- (id)goForward{
    return [(WKWebView*)self.realWebView goForward];
}
- (id)reload{
    return [(WKWebView*)self.realWebView reload];
}
- (id)reloadFromOrigin{
    return [(WKWebView*)self.realWebView reloadFromOrigin];
}
- (void)stopLoading{
    [self.realWebView stopLoading];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler{
    return [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}
-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString{
    __block NSString* result = nil;
    __block BOOL isExecuted = NO;
    [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
        result = obj;
        isExecuted = YES;
    }];
    
    while (isExecuted == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    return result;
}
-(void)setScalesPageToFit:(BOOL)scalesPageToFit{
    if(_scalesPageToFit == scalesPageToFit){
        return;
    }
    WKWebView* webView = _realWebView;
    NSString *jScript = @"var meta = document.createElement('meta'); \
    meta.name = 'viewport'; \
    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
    var head = document.getElementsByTagName('head')[0];\
    head.appendChild(meta);";
    
    if(scalesPageToFit){
        WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
        [webView.configuration.userContentController addUserScript:wkUScript];
    }else{
        NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
        for (WKUserScript *wkUScript in array){
            if([wkUScript.source isEqual:jScript]){
                [array removeObject:wkUScript];
                break;
            }
        }
        for (WKUserScript *wkUScript in array){
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
    }
    _scalesPageToFit = scalesPageToFit;
}
-(BOOL)scalesPageToFit{
    return _scalesPageToFit;
}

-(NSInteger)countOfHistory{
    WKWebView* webView = self.realWebView;
    return webView.backForwardList.backList.count;
}
-(void)gobackWithStep:(NSInteger)step{
    if(self.canGoBack == NO)
        return;
    
    if(step > 0){
        NSInteger historyCount = self.countOfHistory;
        if(step >= historyCount){
            step = historyCount - 1;
        }
        WKWebView* webView = self.realWebView;
        WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
        [webView goToBackForwardListItem:backItem];
    }else{
        [self goBack];
    }
}
#pragma mark-  如果没有找到方法 去realWebView 中调用

-(BOOL)respondsToSelector:(SEL)aSelector{
    BOOL hasResponds = [super respondsToSelector:aSelector];
    if(hasResponds == NO){
        hasResponds = [self.delegate respondsToSelector:aSelector];
    }
    if(hasResponds == NO){
        hasResponds = [self.realWebView respondsToSelector:aSelector];
    }
    return hasResponds;
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector{
    NSMethodSignature* methodSign = [super methodSignatureForSelector:selector];
    if(methodSign == nil){
        if([self.realWebView respondsToSelector:selector]){
            methodSign = [self.realWebView methodSignatureForSelector:selector];
        }else{
            methodSign = [(id)self.delegate methodSignatureForSelector:selector];
        }
    }
    return methodSign;
}
- (void)forwardInvocation:(NSInvocation*)invocation{
    if([self.realWebView respondsToSelector:invocation.selector]){
        [invocation invokeWithTarget:self.realWebView];
    }else{
        [invocation invokeWithTarget:self.delegate];
    }
}

#pragma mark- 清理
-(void)dealloc{
    WKWebView* webView = _realWebView;
    webView.UIDelegate = nil;
    webView.navigationDelegate = nil;
    
    [webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [webView removeObserver:self forKeyPath:@"title"];
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}

#pragma mark ---- NSNotification

-(void)WebViewFontSizeScale{
    NSString *js = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%@%%'",TT_USERDEFAULT_object(TTWebViewFontSizeScale)];
    [self.realWebView evaluateJavaScript:js completionHandler:nil];
}

@end

