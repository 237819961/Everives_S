//
//  YRWithDrawalViewController
//  Everives_S
//
//  Created by darkclouds on 16/4/23.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRWithDrawalViewController.h"

@interface YRWithDrawalViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UIView *tableFooter;
@property(nonatomic,assign) NSInteger seletedPayWay;// 0微信 1支付宝  默认0
@property(nonatomic,strong) UIImageView *wechatRightImage;
@property(nonatomic,strong) UIImageView *aliRightImage;
@end

@implementation YRWithDrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = self.tableFooter;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?3:2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.section*2+indexPath.row) {
        case 0:
        {
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 100, 50)];
            titleL.text = @"可提现金额";
            UILabel *balance = [[UILabel alloc] initWithFrame:CGRectMake(120, 16, kScreenWidth-200, 35)];
            balance.text = @"   2000";
            balance.layer.borderWidth = 0.5;
            balance.layer.borderColor = [UIColor lightGrayColor].CGColor;
            balance.layer.cornerRadius = 5;
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:balance];
            break;
        }
        case 1:
        {
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(16, 8, 100, 50)];
            titleL.text = @"提现金额";
            UITextField *numberInput = [[UITextField alloc] initWithFrame:CGRectMake(120, 16, kScreenWidth-200, 35)];
            numberInput.leftView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, 16, 16)];
            numberInput.leftViewMode = UITextFieldViewModeAlways;
            numberInput.layer.borderWidth = 0.5;
            numberInput.layer.borderColor = [UIColor lightGrayColor].CGColor;
            numberInput.layer.cornerRadius = 5;
            numberInput.placeholder = @"请填写金额";
            numberInput.keyboardType = UIKeyboardTypeNumberPad;
            numberInput.delegate = self;
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:numberInput];
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"支付方式";
            break;
        }
        case 3:
        {
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 9, 40, 40)];
            leftImage.image = [UIImage imageNamed:@"MyWallet_WechatPayment"];
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(71, 0, 200, 60)];
            titleL.text = @"微信钱包支付";
            _wechatRightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 17.5, 25, 25)];
            _wechatRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
            [cell.contentView addSubview:leftImage];
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:_wechatRightImage];
            break;
        }
        case 4:
        {
            UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 9, 40, 40)];
            leftImage.image = [UIImage imageNamed:@"MyWallet_Alipay"];
            UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(71, 0, 200, 60)];
            titleL.text = @"微信钱包支付";
            _aliRightImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 17.5, 25, 25)];
            _aliRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
            [cell.contentView addSubview:leftImage];
            [cell.contentView addSubview:titleL];
            [cell.contentView addSubview:_aliRightImage];
            break;
        }
        default:
            break;
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *sectionHeaderID = @"headerID";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeaderID];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:sectionHeaderID];
    }
    header.backgroundColor = [UIColor lightGrayColor];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    switch (indexPath.section*2+indexPath.row) {
        case 0:
        case 1:
        case 2:
        {
            return;
        }
        case 3://微信
        {
            _seletedPayWay = 0;
            _wechatRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
            _aliRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
            break;
        }
        case 4://支付宝
        {
            _seletedPayWay = 1;
            _wechatRightImage.image = [UIImage imageNamed:@"Pay_NotSelected"];
            _aliRightImage.image = [UIImage imageNamed:@"Pay_Selected"];
            break;
        }
        default:
            break;
    }
}

-(UIView *)tableFooter{
    if (!_tableFooter) {
        _tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 40, kScreenWidth-160, 50)];
        [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        [sureBtn setBackgroundColor:kCOLOR(43, 162, 238)];
        sureBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        sureBtn.layer.borderWidth = 0.5;
        sureBtn.layer.cornerRadius = 25;
        [_tableFooter addSubview:sureBtn];
        
    }
    return _tableFooter;
}
-(void)sureBtnClick:(UIButton*)sender{
    
}
#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

@end
