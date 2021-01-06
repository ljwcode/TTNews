//
//  SettingViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/26.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "SettingViewController.h"
#import <Masonry/Masonry.h>
#import "PrivacyViewController.h"
#import "clearCacheTools.h"
#import "NetWorkConfigureViewController.h"
#import "PushNotificationSettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *footerView;

@property(nonatomic,strong)NSArray *fontSizeArray;

@end

@implementation SettingViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewDidLayoutSubviews{
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backToParentVCHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    self.title = @"设置";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark ---------- UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *ResultCell = nil;
    switch(indexPath.section){
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = @"隐私设置";
                UIImageView *rightArrowImgView = [[UIImageView alloc]init];
                [rightArrowImgView setImage:[UIImage imageNamed:@"arrow_right_setup"]];
                [cell addSubview:rightArrowImgView];
                [rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(-2 * hSpace);
                    make.centerY.mas_equalTo(cell);
                    make.width.height.mas_equalTo(20);
                }];
            }
            ResultCell = cell;
        }
            break;
            
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    if(@available(iOS 13.0,*)){
                        cell.textLabel.text = @"深色模式";
                        UILabel *darkModelTipLabel = [[UILabel alloc]init];
                        darkModelTipLabel.text = @"已关闭";
                        darkModelTipLabel.textColor = [UIColor grayColor];
                        darkModelTipLabel.font = [UIFont systemFontOfSize:13.f];
                        darkModelTipLabel.textAlignment = NSTextAlignmentCenter;
                        [cell addSubview:darkModelTipLabel];
                        [darkModelTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.mas_equalTo(cell);
                            make.right.mas_equalTo(-5 * hSpace);
                            make.width.mas_equalTo(3 * hSpace);
                            make.height.mas_equalTo(2 * hSpace);
                        }];
                        
                        UIImageView *rightArrowImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right_setup"]];
                        [cell addSubview:rightArrowImgView];
                        [rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(darkModelTipLabel.mas_right).mas_equalTo(hSpace);
                            make.right.mas_equalTo(-2 * hSpace);
                            make.centerY.mas_equalTo(cell);
                            make.width.height.mas_equalTo(20);
                        }];
                    }else{
                       
                        cell.textLabel.text = @"夜间模式";
                        UISwitch *switchOnNight = [[UISwitch alloc]init];
                        switchOnNight.on = [[NSUserDefaults standardUserDefaults]objectForKey:@"TT_NightSwitchID"];
                        [switchOnNight addTarget:self action:@selector(switchOnNightHandle:) forControlEvents:UIControlEventTouchUpInside];
                        [cell addSubview:switchOnNight];
                        [switchOnNight mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.mas_equalTo(-2 * hSpace);
                            make.centerY.mas_equalTo(cell);
                        }];
                    }
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"字体大小";
                    UILabel *fontSizeTipLabel = [[UILabel alloc]init];
                    fontSizeTipLabel.text = @"中";
                    fontSizeTipLabel.font = [UIFont systemFontOfSize:13.f];
                    fontSizeTipLabel.textColor = [UIColor grayColor];
                    fontSizeTipLabel.textAlignment = NSTextAlignmentCenter;
                    [cell addSubview:fontSizeTipLabel];
                    [fontSizeTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(cell);
                        make.right.mas_equalTo(-5 * hSpace);
                        make.width.height.mas_equalTo(2 * hSpace);
                    }];
                    UIImageView *rightArrowImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_right_setup"]];
                    [cell addSubview:rightArrowImgView];
                    [rightArrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(cell);
                        make.right.mas_equalTo(-2 * hSpace);
                        make.width.height.mas_equalTo(2 * hSpace);
                    }];
                }
            }
            ResultCell = cell;
        }
            break;
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    cell.textLabel.text = @"清除缓存";
                    UILabel *clearCacheTipLabel = [[UILabel alloc]init];
                    NSString *CachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                    [UIView animateWithDuration:2.f animations:^{
                        clearCacheTipLabel.text = @"计算中...";
                    } completion:^(BOOL finished) {
                        if(finished){
                            clearCacheTipLabel.text = [NSString stringWithFormat:@"%@MB",[clearCacheTools getCacheSizeWithFilePath:CachePath]];
                        }
                    }];
                    clearCacheTipLabel.textColor = [UIColor grayColor];
                    clearCacheTipLabel.textAlignment = NSTextAlignmentCenter;
                    clearCacheTipLabel.font = [UIFont systemFontOfSize:13.f];
                    [cell addSubview:clearCacheTipLabel];
                    
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"网络设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }else if(indexPath.row == 2){
                    cell.textLabel.text = @"推送通知设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }else if(indexPath.row == 3){
                    cell.textLabel.text = @"提示音开关";
                    UISwitch *tipSoundSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.1, cell.frame.size.height/2)];
                    tipSoundSwitch.on = false;
                    cell.accessoryView = tipSoundSwitch;
                }
            }
            ResultCell = cell;
        }
            break;
        case 3:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    cell.textLabel.text = @"H5广告过滤";
                    cell.detailTextLabel.text = @"智能过滤网站广告,为你节省更多流量";
                    UISwitch *adSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.1, cell.frame.size.height/2)];
                    adSwitch.on = false;
                    cell.accessoryView = adSwitch;
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"头条封面";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            ResultCell = cell;
        }
            break;
        case 4:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    cell.textLabel.text = @"检查版本";
                    UIButton *checkUpdataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    checkUpdataBtn.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.2, cell.frame.size.height);
                    [checkUpdataBtn setTitle:@"7.9.3" forState:UIControlStateNormal];
                    checkUpdataBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
                    checkUpdataBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                    [checkUpdataBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [checkUpdataBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
                    checkUpdataBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -checkUpdataBtn.imageView.intrinsicContentSize.width, 0, checkUpdataBtn.imageView.intrinsicContentSize.width);
                    checkUpdataBtn.imageEdgeInsets = UIEdgeInsetsMake(0, checkUpdataBtn.titleLabel.intrinsicContentSize.width, 0, -checkUpdataBtn.titleLabel.intrinsicContentSize.width);
                    [checkUpdataBtn addTarget:self action:@selector(clearCacheHandle:) forControlEvents:UIControlEventTouchUpInside];
                    cell.accessoryView = checkUpdataBtn;
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"关于头条";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            ResultCell = cell;
        }
            break;
        
    }
    
    return ResultCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];

}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            PrivacyViewController *privacyVC = [[PrivacyViewController alloc]init];
            [self.navigationController pushViewController:privacyVC animated:YES];
        }
            break;
        case 1:{
            if(indexPath.row == 0){
                
            }else if(indexPath.row == 1){
                UIAlertController *configureFontVC = [UIAlertController alertControllerWithTitle:@"" message:@"设置字体大小" preferredStyle:UIAlertControllerStyleActionSheet];
                for(int i = 0;i < self.fontSizeArray.count;i++){
                    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:self.fontSizeArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        UIButton *btn = (UIButton *)[tableView viewWithTag:10031];
                        [btn setTitle:self.fontSizeArray[i] forState:UIControlStateNormal];
                    }];
                    [configureFontVC addAction:alertAction];
                }
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [configureFontVC addAction:cancelAction];
                [self presentViewController:configureFontVC  animated:YES completion:nil];
                
            }
        }
            break;
        case 2:{
            if(indexPath.row == 0){
                NSString *CachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
                
                UIAlertController *alertSheetVC = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除所有缓存？离线内容及图片均会被删除" preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [UIView animateWithDuration:1.f animations:^{
                        [clearCacheTools clearCacheWithFilePath:CachePath];
                    } completion:^(BOOL finished) {
                        UIButton *clearBtn = (UIButton *)[self.tableView viewWithTag:10011];
                        [clearBtn setTitle:@"0.00MB" forState:UIControlStateNormal];
                    }];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alertSheetVC addAction:sureAction];
                [alertSheetVC addAction:cancelAction];
                [self presentViewController:alertSheetVC animated:YES completion:nil];
            }else if(indexPath.row == 1){
                NetWorkConfigureViewController *NetConfigureVC = [[NetWorkConfigureViewController alloc]init];
                [self.navigationController pushViewController:NetConfigureVC animated:YES];
            }else if(indexPath.row == 2){
                PushNotificationSettingViewController *pushNotiVC = [[PushNotificationSettingViewController alloc]init];
                [self.navigationController pushViewController:pushNotiVC animated:YES];
            }
        }
            
        default:
            break;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark ---------- 事件响应
-(void)backToParentVCHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)switchOnNightHandle:(UISwitch *)sender{
    sender.selected = !sender.selected;
    if(sender.selected){
        sender.on = YES;
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"TT_NightSwitchID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }else{
        sender.on = NO;
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"TT_NightSwitchID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    NSLog(@"switch = %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"TT_NightSwitchID"]);
}

#pragma mark ------ lazy load
-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
        _tableView.tableFooterView = self.footerView;
    }
    return _tableView;
}

-(UIView *)footerView{
    if(!_footerView){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame)/2, 20)];
        tipLabel.center = view.center;
        tipLabel.text = @"All Rights Reserved By Toutiao.com";
        tipLabel.textColor = [UIColor lightGrayColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:13.f];
        [view addSubview:tipLabel];
        _footerView = view;
    }
    return _footerView;
}

-(NSArray *)fontSizeArray{
    if(!_fontSizeArray){
        _fontSizeArray = [NSArray arrayWithObjects:@"小",@"中",@"大",@"特大", nil];
    }
    return _fontSizeArray;
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
