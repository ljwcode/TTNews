//
//  QRCodePreviewVIew.h
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class QRCodePreviewVIew;
@protocol QRCodePreviewVIewDelegate <NSObject>

- (void)codeScanningView:(QRCodePreviewVIew *)scanningView didClickedTorchSwitch:(UIButton *)switchButton;

@end

@interface QRCodePreviewVIew : UIView

@property (nonatomic, assign, readonly) CGRect rectFrame;
@property (nonatomic, weak) id<QRCodePreviewVIewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectColor:(UIColor *)rectColor;
- (instancetype)initWithFrame:(CGRect)frame rectFrame:(CGRect)rectFrame;

- (void)startScanning;
- (void)stopScanning;
- (void)startIndicating;
- (void)stopIndicating;
- (void)showTorchSwitch;
- (void)hideTorchSwitch;

@end

NS_ASSUME_NONNULL_END
