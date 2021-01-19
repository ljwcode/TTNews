//
//  TTFontSizeChangeHeader.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/8.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#ifndef TTFontSizeChangeHeader_h
#define TTFontSizeChangeHeader_h

#define TT_DEFAULT_FONT @"TT_DEFAULT_FONT"

#define TT_ALL_FONT_CHANGE @"TT_ALL_FONT_CHANGE"

#define TabBarViewHeight @"tabBarHeight"

#define TabBarImgWidth @"TabBarImgWidth"

#define TabBarImgHeight @"TabBarImgHeight"

static float TT_DEFAULT_FONT_SIZE = 15.f;

static float TabBarHeight_SIZE  = 49.0;

static CGFloat tabBarImgWidth_SIZE = 20;

static CGFloat tabBarImgHeight_SIZE = 20;

#define TTFont(FontSize) [UIFont systemFontOfSize:(FontSize)]

#define TT_USERDEFAULT_float(key) [[NSUserDefaults standardUserDefaults] floatForKey:key]
#define TT_USERDEFAULT [NSUserDefaults standardUserDefaults]
#define TT_USERDEFAULT_value(key) [[NSUserDefaults standardUserDefaults] valueForKey:key]

#define TT_USERDEFAULT_object(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define TT_USERDEFAULT_BOOL(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
#define TT_USERDEFAULT_integer(key) [[NSUserDefaults standardUserDefaults] integerForKey:key]

#define TT_USERDEFAULT_int(key) [[[NSUserDefaults standardUserDefaults] objectForKey:key] intValue]

#define TT_USERDEFAULT_SET_value(_value_,_key_) [[NSUserDefaults standardUserDefaults] setValue:_value_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define TT_USERDEFAULT_SET_object(_object_,_key_) [[NSUserDefaults standardUserDefaults] setObject:_object_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define TT_USERDEFAULT_SET_int(_int_,_key_) NSString *uIntString=[NSString stringWithFormat:@"%d",_int_];\
[[NSUserDefaults standardUserDefaults] setObject:uIntString forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define TT_USERDEFAULT_SET_float(_float_,_key_) NSString *uFloatString=[NSString stringWithFormat:@"%f",_float_];\
[[NSUserDefaults standardUserDefaults] setObject:uFloatString forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize]

#define TT_USERDEFAULT_SET_bool(_bool_,_key_)   [[NSUserDefaults standardUserDefaults]setBool:_bool_ forKey:_key_];\
[[NSUserDefaults standardUserDefaults] synchronize];

#endif /* TTFontSizeChangeHeader_h */
