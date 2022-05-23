//
//  NetWorkConfigureViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/10/27.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "NetWorkConfigureViewController.h"

@interface NetWorkConfigureViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *msgArray;

@property(nonatomic,strong)NSArray *tipMsgArray;

@end

@implementation NetWorkConfigureViewController

-(void)viewDidLayoutSubviews{
    self.title = @"网络设置";
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"tta_backbutton_titlebar"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarItemHandle:)];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

#pragma mark ------ UITableViewDelegate && UITableViewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *ResultCell = nil;
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"非WIFI网络流量";
            UIButton *tipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.4, CGRectGetHeight(cell.frame))];
            [tipBtn setTag:10012];
            [tipBtn setTitle:@"极省流量(不下载图)" forState:UIControlStateNormal];
            tipBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            tipBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [tipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tipBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
            tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, tipBtn.titleLabel.intrinsicContentSize.width, 0, -tipBtn.titleLabel.intrinsicContentSize.width);
            tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -tipBtn.imageView.intrinsicContentSize.width, 0, tipBtn.imageView.intrinsicContentSize.width);
            cell.accessoryView = tipBtn;
        }
        ResultCell = cell;
    }else if(indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.textLabel.text = @"非WIFI网络播放提醒";
            UIButton *tipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(cell.frame)*0.25, CGRectGetHeight(cell.frame))];
            [tipBtn setTag:10013];
            [tipBtn setTitle:@"提醒一次" forState:UIControlStateNormal];
            tipBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
            tipBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [tipBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tipBtn setImage:[UIImage imageNamed:@"arrow_right_setup"] forState:UIControlStateNormal];
            tipBtn.imageEdgeInsets = UIEdgeInsetsMake(0, tipBtn.titleLabel.intrinsicContentSize.width, 0, -tipBtn.titleLabel.intrinsicContentSize.width);
            tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -tipBtn.imageView.intrinsicContentSize.width, 0, tipBtn.imageView.intrinsicContentSize.width);
            cell.accessoryView = tipBtn;
        }
        ResultCell = cell;
    }
    
    return ResultCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"非WI-FI网络流量" preferredStyle:UIAlertControllerStyleActionSheet];
        for(int i = 0;i<=2;i++){
            UIAlertAction *Action = [UIAlertAction actionWithTitle:self.msgArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIButton *btn = (UIButton *)[self.tableView viewWithTag:10012];
                [btn setTitle:action.title forState:UIControlStateNormal];
            }];
            [alertVC addAction:Action];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else if(indexPath.row == 1){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"" message:@"非WI-FI网络播放提醒" preferredStyle:UIAlertControllerStyleActionSheet];
        for(int i = 0;i <= 1;i++){
            UIAlertAction *TipAction = [UIAlertAction actionWithTitle:self.tipMsgArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIButton *btn = (UIButton *)[self.tableView viewWithTag:10013];
                [btn setTitle:self.tipMsgArray[i] forState:UIControlStateNormal];
            }];
            [alertVC addAction:TipAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
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

-(NSArray *)msgArray{
    if(!_msgArray){
        _msgArray = [NSArray arrayWithObjects:@"最佳效果 (下载大图)",@"较省流量（智能下图)",@"级省流量 (不下载图)", nil];
    }
    return _msgArray;
}

-(NSArray *)tipMsgArray{
    if(!_tipMsgArray){
        _tipMsgArray = [NSArray arrayWithObjects:@"每次提醒",@"提醒一次", nil];
    }
    return _tipMsgArray;
}

#pragma mark ----- 响应事件
-(void)backBarItemHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
