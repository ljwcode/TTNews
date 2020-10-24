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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
