//
//  focusViewController.m
//  ljwcodeHeadLineNews
//
//  Created by 1 on 2020/8/13.
//  Copyright © 2020 ljwcode. All rights reserved.
//

#import "focusViewController.h"
#import "TTNavigationController.h"

@interface focusViewController()


@end

@implementation focusViewController

-(void)createNaviItem{
    UIImage *leftBackImg = [[UIImage imageNamed:@"lefterbackicon_titlebar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftBackBarItem = [[UIBarButtonItem alloc]initWithImage:leftBackImg style:UIBarButtonItemStylePlain target:self action:@selector(leftBackHandle:)];
    self.navigationItem.leftBarButtonItem = leftBackBarItem;
    
    UIImage *addFriImg = [[UIImage imageNamed:@"weitoutiao_add_friend"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *addFriBarItem = [[UIBarButtonItem alloc]initWithImage:addFriImg style:UIBarButtonItemStylePlain target:self action:@selector(addFriHandle:)];
    self.navigationItem.rightBarButtonItem = addFriBarItem;
}

-(void)viewDidLoad{
//    [self createNaviItem];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
//
//#pragma mark -- UITableViewDelegate && UITableViewDatasource
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(tableView.tag == 0){
//        return 1;
//    }else{
//        return 2;
//    }
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellID = @"cellID";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if(!cellID){
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    if(tableView.tag == 0){
//        cell.textLabel.text = @"用户";
//    }else if(tableView.tag == 1){
//        cell.textLabel.text = @"话题";
//    }else{
//        cell.textLabel.text = @"专题";
//    }
//    return cell;
//}

#pragma mark - TTScrollStatusDelegate

-(void)refreshViewWithTag:(NSInteger)tag isHeader:(BOOL)isHeader{
    NSLog(@".......");
}

#pragma mark - 点击事件

-(void)leftBackHandle:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addFriHandle:(UIBarButtonItem *)sender{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
