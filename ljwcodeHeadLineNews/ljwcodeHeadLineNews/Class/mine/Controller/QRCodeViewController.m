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

@interface QRCodeViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong)QRCodePreviewVIew *QRPreviewView;

@property(nonatomic,strong)QRCodeManager *QRManager;

@end

@implementation QRCodeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self startScanning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    _QRPreviewView = [[QRCodePreviewVIew alloc]initWithFrame:self.view.bounds];
    _QRPreviewView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_QRPreviewView];
    
    _QRManager = [[QRCodeManager alloc]initWithPreviewView:_QRPreviewView completion:^{
        [self startScanning];
    }];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.QRManager stopScanning];
}

-(void)createUI{
    self.title = @"二维码/条形码";
    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"comment_picture_image"] style:UIBarButtonItemStylePlain target:self action:@selector(selectedImgScanHandle:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backToParentVCHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
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
