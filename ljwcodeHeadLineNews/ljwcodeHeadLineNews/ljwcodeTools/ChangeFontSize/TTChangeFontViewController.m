//
//  TTChangeFontViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2021/1/8.
//  Copyright © 2021 ljwcode. All rights reserved.
//

#import "TTChangeFontViewController.h"

@interface TTChangeFontViewController ()

@end

@implementation TTChangeFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TTFontChangeHandle) name:TT_ALL_FONT_CHANGE object:nil];
    // Do any additional setup after loading the view.
}

-(void)TTFontChangeHandle{
    
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
