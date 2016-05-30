//
//  YRSettingController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/28.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRSettingController.h"
#import "YRSettingCell.h"
#import "YRYJNavigationController.h"
#import "YRPrivacySettingController.h"
#import "REFrostedViewController.h"
#import "YRAboutUsViewController.h"
#import "YRFeedBackController.h"
@interface YRSettingController ()
{
    NSArray *_menuArray;
}
@end

@implementation YRSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.frostedViewController.panGestureEnabled = YES;
    _menuArray = @[@[@"隐私设置"],@[@"系统通知提醒",@"驾友消息提醒",@"驾友圈消息提醒"],@[@"关于我们",@"用户反馈"]];
    self.tableView.backgroundColor = kCOLOR(241, 241, 241);
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"menu_icon"] highImage:[UIImage imageNamed:@"menu_icon"] target:(YRYJNavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (KUserManager.id) {
        [self.tableView reloadData];
    }
    self.frostedViewController.panGestureEnabled = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.frostedViewController.panGestureEnabled = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _menuArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_menuArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"settingID";
    YRSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.section==1) {
        cell.swithHidden = NO;
        NSDictionary *dic = @{
                              @"0":@"000",
                              @"1":@"001",
                              @"2":@"010",
                              @"3":@"011",
                              @"4":@"100",
                              @"5":@"101",
                              @"6":@"110",
                              @"7":@"111"
                              };
        //开关状态
        if (KUserManager.id) {
            NSInteger pushID = [dic[[NSString stringWithFormat:@"%ld",KUserManager.push]] integerValue];
            if (indexPath.row == 0) {
                cell.swithStatus = pushID/100;
            }else if(indexPath.row == 1){
                cell.swithStatus = pushID%100/10;
            }else{
                cell.swithStatus = pushID%100%10;
            }
        }else
            cell.swithStatus = NO;
    }else{
        if (indexPath.row !=2) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.swithHidden = YES;
    }
    //开关事件
    [cell setSwithcIsOn:^(BOOL swithOn) {
        if (!KUserManager.id) {
            return;
        }
        NSDictionary *dic = @{
                              @"0":@"000",
                              @"1":@"001",
                              @"2":@"010",
                              @"3":@"011",
                              @"4":@"100",
                              @"5":@"101",
                              @"6":@"110",
                              @"7":@"111"
                              };
        NSString *pushString;
        NSInteger pushID = [dic[[NSString stringWithFormat:@"%ld",KUserManager.push]] integerValue];
        if (indexPath.row == 0) {
            pushString = [NSString stringWithFormat:@"%d%ld%ld",swithOn,pushID%100/10,pushID%100%10];
        }else if(indexPath.row == 1){
            pushString = [NSString stringWithFormat:@"%ld%d%ld",pushID/100,swithOn,pushID%100%10];
        }else{
            pushString = [NSString stringWithFormat:@"%ld%ld%d",pushID/100,pushID%100/10,swithOn];
        }
        NSDictionary *dic1 = @{
                               @"000":@"0",
                               @"001":@"1",
                               @"010":@"2",
                               @"011":@"3",
                               @"100":@"4",
                               @"101":@"5",
                               @"110":@"6",
                               @"111":@"7"
                               };
        [RequestData PUT:@"/student/setting" parameters:@{@"push":dic1[pushString]} complete:^(NSDictionary *responseDic) {
            MyLog(@"%@",responseDic);
            [YRPublicMethod changeUserMsgWithKeys:@[@"push"] values:@[@([dic1[pushString] integerValue])]];
            KUserManager.push = [dic1[pushString] integerValue];
            [self.tableView reloadData];
        } failed:^(NSError *error) {
            [self.tableView reloadData];
        }];
    }];
    
    //如果是系统版本，直接在cell上添加版本信息
    UIFont *font;
//    if (!(indexPath.section == 2 &&indexPath.row == 2)) {
        cell.textLabel.text = _menuArray[indexPath.section][indexPath.row];
        font = cell.textLabel.font;
//    }else{
//        // 当前应用软件版本  比如：1.0.1
//        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//        NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//        UILabel *leftL = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 44)];
//        leftL.text = @"系统版本";
//        leftL.font = font;
//        UILabel *rightL = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, kScreenWidth-100-20, 44)];
//        rightL.textAlignment = NSTextAlignmentRight;
//        rightL.text = appCurVersion;
//        rightL.font = font;
//        [cell.contentView addSubview:leftL];
//        [cell.contentView addSubview:rightL];
//        
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.1;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        YRPrivacySettingController *spVC = [[YRPrivacySettingController alloc]init];
        [self.navigationController pushViewController:spVC animated:YES];
    }
    //关于我们
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            YRAboutUsViewController *about = [[YRAboutUsViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }else if (indexPath.row == 1){
            YRFeedBackController *feedbackVC = [[YRFeedBackController alloc]initWithNibName:@"YRFeedBackController" bundle:nil];
            [self.navigationController pushViewController:feedbackVC animated:YES];
        }
    }
}
@end
