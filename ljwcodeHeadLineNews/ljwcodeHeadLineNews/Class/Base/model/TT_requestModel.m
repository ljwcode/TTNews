//
//  TT_requestModel.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/2/4.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TT_requestModel.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>
#import <AdSupport/ASIdentifierManager.h>

struct utsname systemInfo;

@implementation TT_requestModel

/*
 https://api5-normal-c-lq.snssdk.com/article/category/get_subscribed/v4/?version_code=8.0.9&tma_jssdk_version=1.95.0.19&app_name=news_article&app_version=8.0.9&vid=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&device_id=157930857702792&channel=App%20Store&resolution=750*1334&aid=13&update_version_code=80919&cdid=EDDBEF16-CAA0-4624-8789-5BA3E024EF5E&idfv=B3232A5F-0CD1-4E75-9FEA-0A6DB758753F&ac=WIFI&os_version=12.4.8&ssmix=a&device_platform=iphone&iid=1513346564108847&device_type=iPhone%206&ab_client=a1,f2,f7,e1&idfa=00000000-0000-0000-0000-0000000000000
 */

+(NSString *)version_code{
    return @"8.0.9";
}

+(NSString *)tma_jssdk_version{
    return @"1.95.0.19";
}

+(NSString *)app_name{
    return @"news_article";
}

+(NSString *)app_version{
    return @"8.0.9";
}

+(NSString *)vid{
    return [self idfv];
}

+(NSString *)device_id{
    return @"157930857702792";
}

+(NSString *)channel{
    return @"App Store";
}

+(NSString *)resolution{
    return @"750*1334";
}

+(NSString *)aid{
    return @"13";
}

+(NSString *)update_version_code{
    return @"80919";
}

+(NSString *)cdid{
    return [self idfv];
}

+(NSString *)idfv{
    return [[[UIDevice currentDevice]identifierForVendor]UUIDString];
}

+(NSString *)ac{
    if(@available(iOS 13.0,*)){
        return @"WIFI";
    }
    NSString *wifiName = @"";
    CFArrayRef wifiInterface = CNCopySupportedInterfaces();
    if(!wifiInterface){
        return @"WIFI";
    }
    
    NSArray *Interface = (__bridge NSArray *)wifiInterface;
    for(NSString *interfaceName in Interface){
        CFDictionaryRef dicRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if(dicRef){
            NSDictionary *starGaming_NetInfo = (__bridge NSDictionary *)dicRef;
            wifiName = [starGaming_NetInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dicRef);
        }
    }
    CFRelease(wifiInterface);
    return wifiName;
}

+(NSString *)os_version{
    return [[UIDevice currentDevice]systemVersion];
}

+(NSString *)ssmix{
    return @"a";
}

+(NSString *)device_platform{
    return @"iphone";
}

+(NSString *)iid{
    return @"1513346564108847";
}

+(NSString *)device_type{
    uname(&systemInfo);
    NSString *IOSDeviceType = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if([IOSDeviceType  isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    
    if([IOSDeviceType  isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    
    if([IOSDeviceType  isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    
    if([IOSDeviceType  isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    
    if([IOSDeviceType  isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    
    if([IOSDeviceType  isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    
    if([IOSDeviceType  isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    
    if([IOSDeviceType  isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    
    if([IOSDeviceType  isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    
    if([IOSDeviceType  isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    
    if([IOSDeviceType  isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    
    if([IOSDeviceType  isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    
    if([IOSDeviceType  isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    
    if([IOSDeviceType  isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    
    if([IOSDeviceType  isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    
    if([IOSDeviceType  isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    
    if([IOSDeviceType  isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    
    if([IOSDeviceType  isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    
    if([IOSDeviceType  isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    
    if([IOSDeviceType  isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if([IOSDeviceType  isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if([IOSDeviceType  isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    if([IOSDeviceType  isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    
    if([IOSDeviceType  isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    
    if([IOSDeviceType  isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    
    if([IOSDeviceType isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    
    if([IOSDeviceType isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    
    if([IOSDeviceType isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    
    if([IOSDeviceType isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    
    if([IOSDeviceType isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    
    if([IOSDeviceType isEqualToString:@"iPad4,7"]) return @"iPad mini 3";
    
    if([IOSDeviceType isEqualToString:@"iPad5,1"]) return @"iPad mini 4";
    
    if([IOSDeviceType isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    
    if([IOSDeviceType isEqualToString:@"iPad4,5"]) return @"iPad mini 2 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad4,4"]) return @"iPad mini 2 Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad5,4"]) return @"iPad Air 2 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad4,8"]) return @"iPad mini 3 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad4,9"]) return @"iPad mini 3 Wi-Fi/Cellular CN";
    
    if([IOSDeviceType isEqualToString:@"iPad5,2"]) return @"iPad mini 4 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7 Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad6,11"]) return @"iPad 9.7 5th Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad6,12"]) return @"iPad 9.7 5th Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5 Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5 Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9 2nd Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9 2nd Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,5"]) return @"iPad 9.7 6th Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad7,6"]) return @"iPad 9.7 6th Wi-Fi/Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad8,1"] || [IOSDeviceType isEqualToString:@"iPad8,2"]){
        return @"iPad Pro 11 Wi-Fi Only";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,3"] || [IOSDeviceType isEqualToString:@"iPad8,4"]){
        return @"iPad Pro 11 US/CA WI-Fi/Cellular";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,3"] || [IOSDeviceType isEqualToString:@"iPad8,4"]){
        return @"iPad Pro 11 Global Wi-Fi/Cellular";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,3"] || [IOSDeviceType isEqualToString:@"iPad8,4"]){
        return @"iPad Pro 11 CN Wi-Fi/Cellular";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,5"] || [IOSDeviceType isEqualToString:@"iPad8,6"]){
        return @"iPad Pro 12.9 3rd Wi-Fi Only";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,7"] || [IOSDeviceType isEqualToString:@"iPad8,8"]){
        return @"iPad Pro 12.9 3rd US/CA Wi-Fi/Cellular";
    }
    if([IOSDeviceType isEqualToString:@"iPad8,7"] || [IOSDeviceType isEqualToString:@"iPad8,8"]){
        return @"iPad Pro 12.9 3rd CN Wi-Fi/Cellular";
    }
    
    if([IOSDeviceType isEqualToString:@"iPad11,3"]) return @"iPad Air 3rd Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad11,4"]) return @"iPad Air 3rd US/CA Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad11,4"]) return @"iPad Air 3rd Global Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad11,4"]) return @"iPad Air 3rd CN Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad11,1"]) return @"iPad mini 5th Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad11,2"]) return @"iPad mini 5th US/CA Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad11,2"]) return @"iPad mini 5th Global Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad11,2"]) return @"iPad mini 5th CN Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,11"]) return @"iPad 10.2 7th Wi-Fi Only";
    
    if([IOSDeviceType isEqualToString:@"iPad7,12"]) return @"iPad 10.2 7th US/CA Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,12"]) return @"iPad 10.2 7th Global Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPad7,12"]) return @"iPad 10.2 7th CN Wi-Fi+Cellular";
    
    if([IOSDeviceType isEqualToString:@"iPod5,1"]) return @"iPod touch 5th";
    
    if([IOSDeviceType isEqualToString:@"iPod7,1"]) return @"iPod touch 6th";
    
    if([IOSDeviceType isEqualToString:@"iPod9,1"]) return @"iPod touch 7th";
    
    if([IOSDeviceType isEqualToString:@"iPad11,7"]) return @"iPad 8th generation";
    
    if([IOSDeviceType isEqualToString:@"iPad11,6"]) return @"iPad 8th generation";
    
    if([IOSDeviceType isEqualToString:@"iPad13,1"]) return @"iPad Air 4th generation";
    
    if([IOSDeviceType isEqualToString:@"iPad13,2"]) return @"iPad Air 4th generation";
    
    if([IOSDeviceType isEqualToString:@"iPad8,9"]) return @"iPad Pro 11-inch 2nd generation";
    
    if([IOSDeviceType isEqualToString:@"iPad8,10"]) return @"iPad Pro 11-inch 2nd generation";
    
    if([IOSDeviceType isEqualToString:@"iPad8,11"]) return @"iPad Pro 12.9-inch 4th generation";
    
    if([IOSDeviceType isEqualToString:@"iPad8,12"]) return @"iPad Pro 12.9-inch 4th generation";
    
    if([IOSDeviceType isEqualToString:@"iPhone12,8"]) return @"iPhone SE 2nd generation";
    
    if([IOSDeviceType isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    
    if([IOSDeviceType isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    
    if([IOSDeviceType isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    
    if([IOSDeviceType isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
        
    return IOSDeviceType;
}

+(NSString *)ab_client{
    return @"a1,f2,f7,e1";
}

+(NSString *)idfa{
    return [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
}

@end
