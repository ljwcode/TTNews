//
//  PrivacyViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation PrivacyViewController

-(void)viewDidLayoutSubviews{
    self.title = @"隐私";
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

#pragma mark ------ 响应事件

-(void)backBarItemHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ------ lazy load

-(UITableView *)tableView{
    if(!_tableView){
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark ---- UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else if(section == 1){
        return 3;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *ResultCell = nil;
    switch (indexPath.section) {
        case 0:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                cell.textLabel.text = @"广告设置";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            ResultCell = cell;
        }
            break;
        case 1:{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if(!cell){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
                if(indexPath.row == 0){
                    cell.textLabel.text = @"个人信息收集设置";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }else if(indexPath.row == 1){
                    cell.textLabel.text = @"个性化推荐";
                    cell.detailTextLabel.text = @"关闭后将无法看到个性化推荐内容";
                    UISwitch *recommendationSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.1, CGRectGetHeight(cell.frame)/2)];
                    recommendationSwitch.on = false;
                    cell.accessoryView = recommendationSwitch;
                    
                }else if(indexPath.row == 2){
                    cell.textLabel.text = @"永久清除历史行为";
                    cell.detailTextLabel.text = @"清除后，将无法根据历史兴趣推荐个性化资讯";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
            ResultCell = cell;
        }
        default:
            break;
    }
    return ResultCell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
