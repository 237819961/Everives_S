
//
//  YRUserDetailController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/16.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRUserDetailController.h"
#import "YRUserStatus.h"
#import "UIImageView+WebCache.h"
#import "YRCircleHeadView.h"
#import "YRUserDownView.h"
#import "YRFriendCircleController.h"
#import "YRUserDetailCell.h"
#import "YRFriendCircleController.h"
#import "YREditUserController.h"
#import "YRChatViewController.h"
#import "YRNearViewController.h"
#import "YRYJNavigationController.h"
#import "REFrostedViewController.h"
@interface YRUserDetailController ()<UITableViewDelegate,UITableViewDataSource,YRUserDownViewDelegate>
{
    YRUserStatus *_userMsg;
    NSArray *_msgArray;
    NSArray *_userArray;
    
}
@property (nonatomic, strong) YRCircleHeadView *headView;
@property (nonatomic, strong) YRUserDownView *downView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YRUserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.userID?@"驾友资料":@"个人资料";
    if (self.userID) {
        _msgArray = @[@[@"年龄",@"介绍"],@[@"TA的驾友圈"]];
    }else{
        _msgArray = @[@[@"年龄",@"介绍"],@[@"我的驾友圈"]];
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"SNS_AddContent"] highImage:[UIImage imageNamed:@"SNS_AddContent"] target:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self buildUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
}
-(void)editClick:(UIBarButtonItem *)sender
{
    YREditUserController *editVC = [[YREditUserController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}

-(void)getData
{
    NSString *urlString;
    if (self.userID) {
        urlString = [NSString stringWithFormat:@"%@%@",STUDENT_GET_OTHERSINFO,self.userID];
    }else
        urlString = STUDENT_GET_INFO;
    [RequestData GET:urlString parameters:nil complete:^(NSDictionary *responseDic) {
        MyLog(@"%@",responseDic);
        _userMsg = [YRUserStatus mj_objectWithKeyValues:responseDic];
        [_headView sd_setImageWithURL:[NSURL URLWithString:_userMsg.bg] placeholderImage:[UIImage imageNamed:@"background_1"]];
        [_headView setUserMsgWithName:_userMsg.name gender:[_userMsg.gender boolValue] sign:_userMsg.sign];
        if (self.userID) {
            _headView.imgView.layer.borderColor = kCOLOR(98, 123, 157).CGColor;
        }else{
            _headView.imgView.layer.borderColor = kCOLOR(103, 113, 156).CGColor;
        }
        _headView.imgView.layer.borderWidth = 2;
        _headView.headImgUrl = _userMsg.avatar;
        _userArray = @[@[_userMsg.age,_userMsg.sign],@[@""]];

        if (self.userID) {
            _downView.userStatus = _userMsg;
        }
        [_tableView reloadData];
    } failed:^(NSError *error) {
        
    }];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void)buildUI
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _headView = [[YRCircleHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.6*kScreenWidth)];
    self.tableView.tableHeaderView = _headView;
    if (self.userID) {
        _downView = [[YRUserDownView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
        _downView.delegate = self;
        self.tableView.tableFooterView = _downView;
    }
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _msgArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_msgArray[section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"userdetail";
    YRUserDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[YRUserDetailCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleString = _msgArray[indexPath.section][indexPath.row];
    cell.descriString = _userArray[indexPath.section][indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [YRUserDetailCell userDetailCellGetHeightWith:_userArray[indexPath.section][indexPath.row]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerID"];
    if(!header){
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:@"headerID"];
        header.contentView.backgroundColor = kCOLOR(250, 250, 250);
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {//进入他的驾友圈
        YRFriendCircleController *circleVC = [[YRFriendCircleController alloc]init];
        circleVC.userStatus = _userMsg;
        circleVC.title = [NSString stringWithFormat:@"%@的驾友圈",_userMsg.name];
        [self.navigationController pushViewController:circleVC animated:YES];
    }
}

-(void)userDownViewBtnTag:(NSInteger)btnTag
{
    if (btnTag == 0) {
        if (!_userMsg.relation) {//添加好友
            [RequestData POST:FRIEND_FRIEND parameters:@{@"id":_userMsg.id} complete:^(NSDictionary *responseDic) {
                MyLog(@"%@",responseDic);
                [MBProgressHUD showSuccess:@"请求已发送" toView:GET_WINDOW];
            } failed:^(NSError *error) {
                
            }];
            return;
        }
        //发送消息
        YRChatViewController *conversationVC = [[YRChatViewController alloc]init];
        conversationVC.conversationType = ConversationType_PRIVATE;
        conversationVC.targetId = [NSString stringWithFormat:@"stu%@",_userMsg.id];
        conversationVC.title = _userMsg.name;
        conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
        conversationVC.enableUnreadMessageIcon=YES;
        [self.navigationController pushViewController:conversationVC animated:YES];
        
    }else{//拼教练
        if (!_userMsg.relation) {//不好友
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"拼教练必须先添加好友！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            return;
        }
        YRNearViewController *nearViewController = [[YRNearViewController alloc] init];
        nearViewController.isGoOnLearning = YES;
        nearViewController.isShareOrder = YES;
        nearViewController.partnerModel = _userMsg;
        YRYJNavigationController *navigationController = [[YRYJNavigationController alloc] initWithRootViewController:nearViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
}

@end
