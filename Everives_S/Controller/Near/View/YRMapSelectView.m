//
//  YRMapSelectView.m
//  Everives_S
//
//  Created by darkclouds on 16/3/9.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRMapSelectView.h"
@interface YRMapSelectView()

@end
@implementation YRMapSelectView
-(instancetype)initWithFrame:(CGRect)frame selectedNum:(NSInteger)num{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _selectedBtnNum = num?:1;
        [self addSubview:self.schoolBtn];
        [self addSubview:self.coachBtn];
        [self addSubview:self.studentBtn];
        [self addSubview:self.lineView];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return  self;
}
-(UIButton *)schoolBtn{
    if (!_schoolBtn) {
        _schoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-110, 0, 60, 44)];
        [_schoolBtn setTitle:@"场地" forState:UIControlStateNormal];
        _schoolBtn.titleLabel.font = kFontOfLetterBig;
        [_schoolBtn setTitleColor:_selectedBtnNum==1?[UIColor blackColor]:kTextlightGrayColor forState:UIControlStateNormal];
        [_schoolBtn addTarget:self action:@selector(schoolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _schoolBtn;
}
-(UIButton *)coachBtn{
    if (!_coachBtn) {
        _coachBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-30, 0, 60, 44)];
        [_coachBtn setTitle:@"教练" forState:UIControlStateNormal];
        _coachBtn.titleLabel.font = kFontOfLetterBig;
        [_coachBtn setTitleColor:_selectedBtnNum==2?[UIColor blackColor]:kTextlightGrayColor forState:UIControlStateNormal];
        [_coachBtn addTarget:self action:@selector(coachBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coachBtn;
}
-(UIButton *)studentBtn{
    if (!_studentBtn) {
        _studentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2+50, 0, 60, 44)];
        [_studentBtn setTitle:@"驾友" forState:UIControlStateNormal];
        _studentBtn.titleLabel.font = kFontOfLetterBig;
        [_studentBtn setTitleColor:_selectedBtnNum==3?[UIColor blackColor]:kTextlightGrayColor forState:UIControlStateNormal];
        [_studentBtn addTarget:self action:@selector(studentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _studentBtn;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-110+(_selectedBtnNum-1)*80, 41, 60, 3)];
        _lineView.backgroundColor = kCOLOR(50, 50, 50);
    }
    return _lineView;
}
-(void)schoolBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2-110, 41, 60, 3);
    }];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_coachBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    [_studentBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    _selectedBtnNum = 1;
    sender.tag = 1;
    [self.delegate schoolBtnClick:sender];
}
-(void)coachBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2-30, 41, 60, 3);
    }];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_schoolBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    [_studentBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    _selectedBtnNum = 2;
    sender.tag = 2;
    [self.delegate coachBtnClick:sender];
}
-(void)studentBtnClick:(UIButton*)sender{
    [UIView animateWithDuration:0.4 animations:^{
        _lineView.frame = CGRectMake(kScreenWidth/2+50, 41, 60, 3);
    }];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_coachBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    [_schoolBtn setTitleColor:kTextlightGrayColor forState:UIControlStateNormal];
    _selectedBtnNum = 3;
    sender.tag = 3;
    [self.delegate studentBtnClick:sender];
}
@end
