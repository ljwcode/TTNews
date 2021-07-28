//
//  AppDelegate.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "AppDelegate.h"
#import "TTTabBarController.h"
#import "otherLoginTypeView.h"
#import <realm/Realm.h>
#import "FFSimplePingHelper.h"
#import <AFNetworkReachabilityManager.h>
#import <Bugly/Bugly.h>

@interface AppDelegate (){
    FFSimplePingHelper *pingHelper;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
    [Bugly startWithAppId:@"39a4a6e9d9"];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window.backgroundColor = [UIColor whiteColor];
	[self.window makeKeyAndVisible];
    TTTabBarController *tabbar = [[TTTabBarController alloc]init];
    self.window.rootViewController = tabbar;
    
    
    NSURL* urlToDocumentsFolder = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
      __autoreleasing NSError *error;
      NSDate *installDate = [[[NSFileManager defaultManager] attributesOfItemAtPath:urlToDocumentsFolder.path error:&error] objectForKey:NSFileCreationDate];

      NSLog(@"This app was installed by the user on %@ %f", installDate, [installDate timeIntervalSince1970]);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 1;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [[TTSystemConfigureHelper shareInstance]TT_ConfigurePreference];
    [self TT_InitFontSize];
    
    pingHelper = [[FFSimplePingHelper alloc]initWithHostName:@"www.baidu.com"];
    [pingHelper startPing];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
	return YES;
}
#pragma mark - changeFontSize

-(void)TT_InitFontSize{
    float defaultFont = TT_USERDEFAULT_float(TT_DEFAULT_FONT);
    if(defaultFont == 0){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSUserDefaults *userDefaules = [NSUserDefaults standardUserDefaults];
            [userDefaules setFloat:TT_DEFAULT_FONT_SIZE forKey:TT_DEFAULT_FONT];
            [userDefaules setFloat:TT_isIphoneX ? IPhoneXTabBarHeight_SIZE : TabBarHeight_SIZE forKey:TabBarViewHeight];
            [userDefaules setObject:@"中" forKey:TT_FONTSIZE_TIP];
            [userDefaules setObject:@"180" forKey:TTWebViewFontSizeScale];
            [userDefaules synchronize];
        });
    }
}

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions{
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [pingHelper stopPing];
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[TTSystemConfigureHelper shareInstance]TT_ConfigurePreference];
    [pingHelper startPing];
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 可以这么写
    if (self.allowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
