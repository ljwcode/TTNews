//
//  NSData+CRC32.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/26.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <zlib.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (CRC32)

-(int32_t)crc_32;

-(uLong)getCRC32;

@end

NS_ASSUME_NONNULL_END
