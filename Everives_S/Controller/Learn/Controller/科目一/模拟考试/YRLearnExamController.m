//
//  YRLearnExamController.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRLearnExamController.h"
#import "YRLearnPracticeController.h"
#import "YRExamUserHeadView.h"
#import "UIViewController+YRCommonController.h"

#import "YRLearnNoMsgView.h"
@interface YRLearnExamController ()<YRLearnNoMsgViewDelegate,YRExamUserHeadViewDelegate>
{
    NSArray *_titleArray;
    NSArray *_menuArray;
}
@property (nonatomic, strong) YRExamUserHeadView *headView;

@property (nonatomic, strong) YRLearnNoMsgView *noMsgView;
@end

@implementation YRLearnExamController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"模拟考试";
    
    [self buildUI];
}

-(void)buildUI
{
    _titleArray = @[@"考试科目",@"考试题库",@"考试标准",@"合格标准"];
    if (self.objectFour) {
        _menuArray = @[@"科目四理论考试",@"重庆市科目四理论考试题库",@"30分钟，50题",@"满分100分，90分及格"];
    }else
        _menuArray = @[@"科目一理论考试",@"重庆市科目一理论考试题库",@"45分钟，100题",@"满分100分，90分及格"];
    
    _headView = [[YRExamUserHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth/2)];
    _headView.delegate = self;
    self.tableView.tableHeaderView = _headView;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, footView.height-40, kScreenWidth-40, 45)];
    [startBtn setTitle:@"开始考试" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.backgroundColor = kCOLOR(50, 51, 52);
    [startBtn addTarget:self action:@selector(sartClick:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.layer.masksToBounds = YES;
    startBtn.layer.cornerRadius = startBtn.height/2;
    [footView addSubview:startBtn];
    self.tableView.tableFooterView = footView;
    
//    [self.view bringSubviewToFront:self.noMsgView];
}
-(void)examUserHeadClick
{
    if (!KUserManager.id) {
        [self goToLoginVC];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.headView.loginBool = YES;
}
-(void)sartClick:(UIButton *)sender
{
    YRLearnPracticeController *learnVC = [[YRLearnPracticeController alloc]init];
    learnVC.title = @"模拟考试";
//    learnVC.currentID = 1;
    learnVC.objectFour = self.objectFour;
    learnVC.menuTag = 0;
    [self.navigationController pushViewController:learnVC animated:YES];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = _menuArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    return cell;
}
#pragma mark - YRLearnNoMsgViewDelegate 去认证
-(void)learnNoMsgViewAttestationClick
{
    MyLog(@"%s",__func__);
}
-(YRLearnNoMsgView *)noMsgView
{
    if (!_noMsgView) {
        _noMsgView = [[YRLearnNoMsgView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
        _noMsgView.delegate = self;
        [self.view addSubview:_noMsgView];
    }
    return _noMsgView;
}

@end
