//
//  YRYJLoginViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/3/2.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRYJLoginViewController.h"
#import "CWSLoginTextField.h"
#import "CWSPublicButton.h"
#import "UIButton+titleFrame.h"

#import "YRYJForgetPswViewController.h"
#import "YRYJRegistViewController.h"

#define CWSPercent 0.53
#define CWSLeftDistance 15
#define CWSHeightDistance [[UIScreen mainScreen]applicationFrame].size.height * 0.03961268
@interface YRYJLoginViewController ()

@property (nonatomic, strong) UIView *iconImgView;//大图片
@property (nonatomic, strong) UILabel *titleLabel;//标题
@property (nonatomic, strong) CWSLoginTextField *phoneTF;//手机号码输入框
@property (nonatomic, strong) CWSLoginTextField *passwordTF;//密码输入框
@property (nonatomic, strong) CWSPublicButton *sureBtn;//登录按钮
@property (nonatomic, strong) UIButton *forgetPassWordBtn;//忘记密码按钮
@property (nonatomic, strong) UIButton *registBtn;//注册按钮

@end

@implementation YRYJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    //创建视图
    [self setUI];
}

#pragma mark - 创建视图
- (void)setUI
{
    //logo
    CGFloat weight = kSizeOfScreen.height*(1-CWSPercent) > kSizeOfScreen.width ? kSizeOfScreen.width : kSizeOfScreen.height*(1-CWSPercent);
    _iconImgView = [[UIView alloc]init];
    [self.view addSubview:_iconImgView];
    _iconImgView.frame = CGRectMake(0,CWSHeightDistance,weight*0.6, weight*0.6);
    _iconImgView.center = CGPointMake(kSizeOfScreen.width/2, kSizeOfScreen.height*(1-CWSPercent)/2+20);
    _iconImgView.backgroundColor = [UIColor redColor];
    
    //标题
    _titleLabel = [[UILabel alloc]init];
    [self.view addSubview:_titleLabel];
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_iconImgView.frame)+CWSHeightDistance, kSizeOfScreen.width, 30);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"蚁人约驾（学员）";
    
    //手机号码
    _phoneTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(CWSLeftDistance, kSizeOfScreen.height*CWSPercent, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    _phoneTF.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    _phoneTF.placeholder = @"手机号码";
    [self.view addSubview:_phoneTF];
    //密码
    _passwordTF = [[CWSLoginTextField alloc]initWithFrame:CGRectMake(CWSLeftDistance, _phoneTF.y + _phoneTF.height + CWSHeightDistance, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    _passwordTF.leftImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    _passwordTF.placeholder = @"密码";
    [self.view addSubview:_passwordTF];
    //登录按钮
    _sureBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(CWSLeftDistance, _passwordTF.y + _passwordTF.height +2*CWSHeightDistance, kSizeOfScreen.width - 2 * CWSLeftDistance, 44)];
    [_sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sureBtn];
    
    //忘记密码
    _forgetPassWordBtn = [[UIButton alloc]initWithFrame:CGRectMake(CWSLeftDistance, kSizeOfScreen.height-30 + 20, 80, 30)];
    [_forgetPassWordBtn setFrameWithTitle:@"忘记密码?" forState:UIControlStateNormal];
    [_forgetPassWordBtn addTarget:self action:@selector(forgetPassWordClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_forgetPassWordBtn];
    //新用户注册
    _registBtn = [[UIButton alloc]initWithFrame:CGRectMake(kSizeOfScreen.width - CWSLeftDistance, _forgetPassWordBtn.y, 0, 30)];
    [_registBtn setFrameWithTitle:@"新用户注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
}
#pragma mark - 登录事件
- (void)loginClick:(CWSPublicButton*)sender
{
    NSLog(@"%s",__func__);
}
#pragma mark - 忘记密码事件
- (void)forgetPassWordClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    YRYJForgetPswViewController *forgetPasswordVC = [[YRYJForgetPswViewController alloc]init];
    [self.navigationController pushViewController:forgetPasswordVC animated:YES];
}
#pragma mark - 注册事件
- (void)registClick:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    YRYJRegistViewController *registVC = [[YRYJRegistViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end