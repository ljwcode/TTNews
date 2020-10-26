//
//  SettingViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/26.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "SettingViewController.h"
#import <Masonry/Masonry.h>

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIView *footerView;

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
    UITableViewCell *ResultCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    switch(indexPath.section){
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = @"隐私设置";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            ResultCell = cell;
        }
            break;
            
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    cell.textLabel.text = @"夜间模式";
                    UISwitch *switchOnNight = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.1, cell.frame.size.height/2)];
                    switchOnNight.on = false;
                    cell.accessoryView = switchOnNight;
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"字体大小";
                    UIButton *chooseFontSizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    chooseFontSizeBtn.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.1, cell.frame.size.height/2);
                    [chooseFontSizeBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
                    [chooseFontSizeBtn setTitle:@"中" forState:UIControlStateNormal];
                    [chooseFontSizeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    chooseFontSizeBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                    chooseFontSizeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, chooseFontSizeBtn.titleLabel.intrinsicContentSize.width, 0, -chooseFontSizeBtn.titleLabel.intrinsicContentSize.width);
                    chooseFontSizeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -chooseFontSizeBtn.imageView.intrinsicContentSize.width, 0, chooseFontSizeBtn.imageView.intrinsicContentSize.width);
                    [chooseFontSizeBtn addTarget:self action:@selector(chooseFontSizeHandle:) forControlEvents:UIControlEventTouchUpInside];
                    cell.accessoryView = chooseFontSizeBtn;
                   
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
                    UIButton *clearCacheBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                    clearCacheBtn.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.2, cell.frame.size.height/2);
                    [clearCacheBtn setTitle:@"0.00MB" forState:UIControlStateNormal];
                    clearCacheBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
                    clearCacheBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
                    [clearCacheBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [clearCacheBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
                    clearCacheBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -clearCacheBtn.imageView.intrinsicContentSize.width, 0, clearCacheBtn.imageView.intrinsicContentSize.width);
                    clearCacheBtn.imageEdgeInsets = UIEdgeInsetsMake(0, clearCacheBtn.titleLabel.intrinsicContentSize.width, 0, -clearCacheBtn.titleLabel.intrinsicContentSize.width);
                    [clearCacheBtn addTarget:self action:@selector(clearCacheHandle:) forControlEvents:UIControlEventTouchUpInside];
                    cell.accessoryView = clearCacheBtn;
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
                    checkUpdataBtn.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.15, cell.frame.size.height/2);
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


#pragma mark ---------- 事件响应
-(void)backToParentVCHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)chooseFontSizeHandle:(UIButton *)sender{
    
}

-(void)clearCacheHandle:(UIButton *)sender{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
