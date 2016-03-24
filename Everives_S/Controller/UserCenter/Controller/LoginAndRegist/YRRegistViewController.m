//
//  YRRegistViewController.m
//  蚁人约驾(学员)
//
//  Created by 李洪攀 on 16/3/2.
//  Copyright © 2016年 SkyFish. All rights reserved.
//

#import "YRRegistViewController.h"
#import "CWSPublicButton.h"
#import "JKCountDownButton.h"
#import "CWSReadPolicyView.h"
#import "YRRegistPswController.h"
#import "YRProtocolViewController.h"
#import "PublicCheckMsgModel.h"
#define kDistance 10
#define kTextFieldHeight 44
@interface YRRegistViewController ()<CWSReadPolicyViewDelegate>

@property (nonatomic, strong) UITextField *tellText;
@property (nonatomic, strong) UITextField *codeText;
@property (nonatomic, strong) JKCountDownButton *getCodeBtn;
@property (nonatomic, strong) CWSPublicButton *registBtn;//注册按钮
@property (nonatomic, strong) CWSReadPolicyView *readPolicyView;

@end

@implementation YRRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self buildUI];
    
}
- (void)buildUI
{
    self.view.backgroundColor = kCOLOR(241, 241, 241);

    //手机号码输入框
    self.tellText = [self setTextFieldWithFrame:CGRectMake(kDistance*2, kDistance*2+64, kSizeOfScreen.width-4*kDistance, kTextFieldHeight) withPlaceholder:@"请输入您的手机号"];
    [self.view addSubview:self.tellText];
    
    
    //验证码
    self.codeText = [self setTextFieldWithFrame:CGRectMake(kDistance*2, CGRectGetMaxY(self.tellText.frame)+kDistance, kSizeOfScreen.width-4*kDistance, kTextFieldHeight) withPlaceholder:@"请输入验证码"];
    [self.view addSubview:self.codeText];
    
//    //添加右侧获取验证码按钮
//    self.getCodeBtn = [[JKCountDownButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.codeText.frame)+kDistance, self.codeText.y, (kSizeOfScreen.width-2*kDistance)*0.36-kDistance, kTextFieldHeight)];
//    self.getCodeBtn.backgroundColor = kMainColor;
//    self.getCodeBtn.layer.masksToBounds = YES;
//    self.getCodeBtn.layer.cornerRadius = 4;
//    self.getCodeBtn.layer.borderColor = [kMainColor CGColor];
//    self.getCodeBtn.layer.borderWidth = 1;
//    [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//    [self.getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//
//    //验证码获取
////    WS(ws);
//    [self.getCodeBtn addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
//        
//        
//    }];
//    [self.view addSubview:self.getCodeBtn];
//    [self.getCodeBtn startWithSecond:59];
    
    
    self.registBtn = [[CWSPublicButton alloc]initWithFrame:CGRectMake(kDistance*2, CGRectGetMaxY(self.codeText.frame)+kDistance, self.tellText.width, kTextFieldHeight)];
    [self.registBtn setTitle:@"完成验证" forState:UIControlStateNormal];
    [self.registBtn addTarget:self action:@selector(registClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registBtn];
    
    if ([self.title isEqualToString:@"注册"]) {
        _readPolicyView = [[CWSReadPolicyView alloc]initWithFrame:CGRectMake(self.registBtn.x, self.registBtn.y+self.registBtn.height+20, kSizeOfScreen.width-30, 20)];
        _readPolicyView.delegate = self;
        [self.view addSubview:_readPolicyView];
    }
}

#pragma mark - 快速创建输入框
-(UITextField *)setTextFieldWithFrame:(CGRect)frame withPlaceholder:(NSString *)placehold
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placehold;
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, kTextFieldHeight)];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = textField.height/2;
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(kDistance, 0, 50, textField.height)];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:14];
    textField.leftView = leftLabel;
    if ([placehold isEqualToString:@"请输入您的手机号"]) {
        leftLabel.text = @"+86";

        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, textField.height)];
        [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = btn.height/2;
        btn.layer.borderWidth = 3;
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor lightGrayColor];
        textField.rightView = btn;
        textField.rightViewMode = UITextFieldViewModeAlways;
    }
    
    return textField;
}

-(void)registClick:(CWSPublicButton *)sender
{
    
    [PublicCheckMsgModel checkTellWithTellNum:self.tellText.text complete:^(BOOL isSuccess) {
        
        if (![self.codeText.text isValid]) {
            NSLog(@"验证码不能为空");
            return ;
        }
        
        
        [RequestData GET:USER_CHECK_TELL parameters:@{@"tel":self.tellText.text,@"kind":@"0"} complete:^(NSDictionary *responseDic) {
            NSLog(@"%@",responseDic);
            
            if ([self.title isEqualToString:@"忘记密码"]) {//忘记密码
                NSLog(@"手机号码没有注册");
                return;
            }
            YRRegistPswController *pswVC = [[YRRegistPswController alloc]init];
            pswVC.tellNum = self.tellText.text;
            pswVC.codeNum = self.codeText.text;
            [self.navigationController pushViewController:pswVC animated:YES];
            
        } failed:^(NSError *error) {
            if ([self.title isEqualToString:@"忘记密码"]) {//忘记密码
                YRRegistPswController *pswVC = [[YRRegistPswController alloc]init];
                pswVC.tellNum = self.tellText.text;
                pswVC.codeNum = self.codeText.text;
                [self.navigationController pushViewController:pswVC animated:YES];
                return;
            }
        }];
        
    } error:^(NSString *errorMsg) {
        NSLog(@"%@",errorMsg);
    }];
    
}

#pragma mark - 服务选项代理
//跳转到服务协议界面
-(void)readPolicyViewTurnToPolicyVC
{
    MyLog(@"%s",__func__);
    YRProtocolViewController*policyVC = [[YRProtocolViewController alloc]init];
    [self.navigationController pushViewController:policyVC animated:YES];
}
//是否选择协议
-(void)readPolicyViewTochDown:(BOOL)readOrPolicy
{
//    _readSelect = readOrPolicy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
