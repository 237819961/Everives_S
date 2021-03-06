//
//  YRPrivacySettingController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/29.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRPrivacySettingController.h"
#import "YRSettingPrivacyCell.h"
@interface YRPrivacySettingController ()
{
    NSArray *titleArray;
}
@end

@implementation YRPrivacySettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐私设置";
    titleArray = @[@"在附近中显示距离",@"出现在附件中，不显示距离",@"不出现在附近"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = 55;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"adfa";
    YRSettingPrivacyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YRSettingPrivacyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.textColor = kYRBlackTextColor;
    }
    cell.textLabel.text = titleArray[indexPath.row];
    if (KUserManager.id) {
        if (indexPath.row == KUserManager.show) {
            cell.selectBool = YES;
        }else
            cell.selectBool = NO;
    }else{
        cell.selectBool = NO;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *parameters = @{@"show":[NSString stringWithFormat:@"%li",indexPath.row]};
    [RequestData PUT:@"/student/setting" parameters:parameters complete:^(NSDictionary *responseDic) {
        [YRPublicMethod changeUserMsgWithKeys:@[@"show"] values:@[@(indexPath.row)]];
        KUserManager.show = indexPath.row;
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerID"];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerID"];
    }
    header.contentView.backgroundColor = [UIColor whiteColor];
    return header;
}
@end
