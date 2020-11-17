//
//  PushNotificationSettingViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/29.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "PushNotificationSettingViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "MBProgressHUD+Add.h"
#import "TTCloseNotificationTipView.h"

@interface PushNotificationSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *interactDataArray;

@property(nonatomic,strong)NSArray *focusDataArray;

@property(nonatomic,strong)NSArray *tipDataArray;

@property(nonatomic,assign)BOOL isClose;

@end

@implementation PushNotificationSettingViewController

-(void)viewDidLayoutSubviews{
    self.title = @"推送通知设置";
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isClose = YES;
    if(self.isClose){
        [MBProgressHUD showSuccess:@"点击开启，重要内容不容错过!"];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark ---- UITableViewDelegate && UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch(section){
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 2;
            break;
        case 5:
            return 1;
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *ResultCell = nil;
    switch(indexPath.section){
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                cell.textLabel.text = @"推送通知设置";
                cell.detailTextLabel.text = @"你可能错过重要的资讯通知，点击开启消息通知";
                [cell.detailTextLabel setTag:10014];
                UISwitch *notiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)*0.5)];
                [notiSwitch addTarget:self action:@selector(notiSwitchHandle:) forControlEvents:UIControlEventTouchUpInside];
                notiSwitch.on = false;
                cell.accessoryView = notiSwitch;
                self.isClose = YES;
            }
            ResultCell = cell;
        }
            break;
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = @"重大新闻通知";
                UISwitch *impNotiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)/2)];
                impNotiSwitch.on = false;
                cell.accessoryView = impNotiSwitch;
            }
            ResultCell = cell;
        }
            break;
            
        case 2:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = self.interactDataArray[indexPath.row];
                UISwitch *impNotiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)*0.5)];
                impNotiSwitch.on = false;
                [impNotiSwitch setTag:10015+indexPath.row];
                cell.accessoryView = impNotiSwitch;
            }
            ResultCell = cell;
        }
            break;
        case 3:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = self.focusDataArray[indexPath.row];
                UISwitch *focusNotiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)/2)];
                focusNotiSwitch.on = false;
                [focusNotiSwitch setTag:10018+indexPath.row];
                cell.accessoryView = focusNotiSwitch;
            }
            ResultCell = cell;
        }
            break;
        case 4:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                for(int i = 0;i < self.tipDataArray.count;i++){
                    cell.textLabel.text = self.tipDataArray[i][i];
                    cell.detailTextLabel.text = self.tipDataArray[i][i];
                }
                UISwitch *tipNotiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)/2)];
                tipNotiSwitch.on = false;
                [tipNotiSwitch setTag:10020+indexPath.row];
                cell.accessoryView = tipNotiSwitch;
                
            }
            ResultCell = cell;
        }
            break;
        case 5:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = @"消息免打扰";
                UISwitch *msgNotiSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame)*0.1, CGRectGetHeight(cell.contentView.frame)/2)];
                msgNotiSwitch.on = false;
                cell.accessoryView = msgNotiSwitch;
            }
            ResultCell = cell;
        }
            break;
    }
    return ResultCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return @"重大新闻";
            break;
        case 2:
            return @"互动";
            break;
        case 3:
            return @"关注";
            break;
        case 4:
            return @"预约和订阅";
            break;
        case 5:
            return @"免打扰";
            break;
        default:
            break;
    }
    return @"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            
        }
            break;
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
    return 8;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

#pragma mark ---- lazy load

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

-(NSArray *)interactDataArray{
    if(!_interactDataArray){
        _interactDataArray = @[@"收到评论或回复",@"收到点赞",@"转发"];
    }
    return _interactDataArray;
}

-(NSArray *)focusDataArray{
    if(!_focusDataArray){
        _focusDataArray  = @[@"获得新粉丝",@"关注的人发不了新内容"];
    }
    return _focusDataArray;
}

-(NSArray *)tipDataArray{
    if(!_tipDataArray){
        _tipDataArray = @[@[@"预约提醒",@"订阅提醒"],
                          @[@"影视/直播/赛事等",@"小说/精品课等"]];
    }
    return _tipDataArray;
}

#pragma mark ---- 响应事件
-(void)backBarItemHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)notiSwitchHandle:(UISwitch *)sender{
    sender.selected = !sender.selected;
    if(sender.on){
        [MBProgressHUD showSuccess:@"打开推送通知"];
    }else{
        TTCloseNotificationTipView *closeTipView = [[TTCloseNotificationTipView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.6, kScreenWidth, kScreenHeight * 0.4)];
        [self.view addSubview:closeTipView];
//        [closeTipView show];
    }
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
