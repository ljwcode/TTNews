//
//  QRCodeManager.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodePreviewVIew.h"

NS_ASSUME_NONNULL_BEGIN

@interface QRCodeManager : NSObject

#pragma mark - 扫描二维码/条形码

- (instancetype)initWithPreviewView:(QRCodePreviewVIew *)previewView completion:(void(^)(void))completion;

- (void)startScanningWithCallback:(void(^)(NSString *))callback autoStop:(BOOL)autoStop;
- (void)startScanningWithCallback:(void(^)(NSString *))callback;
- (void)stopScanning;

- (void)presentPhotoLibraryWithRooter:(UIViewController *)rooter callback:(void(^)(NSString *))callback;


#pragma mark - 生成二维码/条形码

+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size;
+ (UIImage *)generateQRCode:(NSString *)code size:(CGSize)size logo:(UIImage *)logo;
+ (UIImage *)generateCode128:(NSString *)code size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
