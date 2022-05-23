//
//  QRCodeViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/24.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "QRCodeViewController.h"
#import "QRCodePreviewVIew.h"
#import "QRCodeManager.h"
#import <Masonry/Masonry.h>


@interface QRCodeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)QRCodePreviewVIew *QRPreviewView;

@property(nonatomic,strong)QRCodeManager *QRManager;

@end

@implementation QRCodeViewController

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self startScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _QRPreviewView = [[QRCodePreviewVIew alloc]initWithFrame:self.view.bounds];
    _QRPreviewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_QRPreviewView];
    [self createUI];
    _QRManager = [[QRCodeManager alloc]initWithPreviewView:_QRPreviewView completion:^{
        [self startScanning];
    }];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.QRManager stopScanning];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)createUI{
    UIButton *leftBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBackBtn setImage:[UIImage imageNamed:@"leftbackbutton_titlebar_photo_preview"] forState:UIControlStateNormal];
    [leftBackBtn addTarget:self action:@selector(backToParentVCHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBackBtn];
    
    [leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo([TTScreen TT_isPhoneX] ? 34 + 10 : 10);
        make.width.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setText:@"二维码/条形码"];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(leftBackBtn);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *selectQRcodePhotoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectQRcodePhotoBtn setImage:[UIImage imageNamed:@"image_upload"] forState:UIControlStateNormal];
    [selectQRcodePhotoBtn addTarget:self action:@selector(selectedImgScanHandle:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectQRcodePhotoBtn];
    
    [selectQRcodePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(leftBackBtn);
        make.width.height.mas_equalTo(leftBackBtn);
    }];
}

#pragma mark ------ 响应事件

-(void)selectedImgScanHandle:(id)sender{
    [self.QRManager presentPhotoLibraryWithRooter:self callback:^(NSString * _Nonnull code) {
        NSLog(@"从相册中选择二维码图片");
    }];
}

-(void)backToParentVCHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private functions

- (void)startScanning {
    [self.QRManager startScanningWithCallback:^(NSString * _Nonnull code) {
        NSLog(@"启动二维码扫描");
    } autoStop:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
