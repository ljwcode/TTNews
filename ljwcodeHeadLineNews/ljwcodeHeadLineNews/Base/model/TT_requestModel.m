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

+(NSString *)version_code{
    return @"8.6.8";
}

+(NSString *)tma_jssdk_version{
    return @"2.25.0.20";
}

+(NSString *)app_name{
    return @"news_article";
}

+(NSString *)app_version{
    return @"8.6.8";
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
    return @"86820";
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
    return @"2115875724858639";
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

+ (NSString *)session_id {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *UUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return UUID;
}

+ (NSString *)list_entrance {
    return @"more_shortvideo";
}

+ (NSString *)ab_feature{
    return @"794526,3408343,1662483";
}

+ (NSString *)caid1{
    return @"097e2185d5a6639cdb19eeb2ceb74267";
}

+ (NSString *)strict {
    return @"0";
}

+(NSString *)ab_group{
    return @"794526,3408343,1662483";
}

+(NSString *)caid2 {
    return @"";
}

+(NSString *)language {
    return @"zh-Hans-CN";
}

+(NSString *)image {
    return @"1";
}

+(NSString *)list_count {
    return @"18";
}

+(NSString *)count {
    return @"20";
}

+(NSString *)tt_from {
    return @"pull";
}

+(NSString *)last_refresh_sub_entrance_interval {
    return [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
}

+(NSString *)loc_time {
    return [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
}

+(NSString *)refer {
    return @"1";
}

+(NSString *)refresh_reason {
    return @"1";
}

+(NSString *)concern_id {
    return @"6286225228934679042";
}

+(NSString *)st_time {
    return @"8620";
}

+(NSString *)session_refresh_idx {
    return @"3";
}

+(NSString *)LBS_status{
    return @"authroize";
}

+(NSString *)rerank {
    return @"0";
}

+(NSString *)detail {
    return @"1";
}

+(NSString *)min_behot_time {
    return [NSString stringWithFormat:@"%f",[[NSDate date]timeIntervalSince1970]];
}

+(NSString *)loc_mode {
    return @"1";
}

+(NSString *)cp {
    return @"6e230cEb0dEC3q1";
}


@end
