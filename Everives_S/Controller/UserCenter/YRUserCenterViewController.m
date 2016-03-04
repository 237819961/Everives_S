//
//  YRUserCenterViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/3.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserCenterViewController.h"

@interface YRUserCenterViewController (){
    NSArray *cellNmaes;
    NSArray *cellImgs;
}
@end

@implementation YRUserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cellNmaes = @[@"我的预约",@"我的钱包",@"我的评价",@"我的进度",@"活动通知",@"信息认证"];
    cellImgs = @[];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?4:2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = cellNmaes[indexPath.section*4+indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
