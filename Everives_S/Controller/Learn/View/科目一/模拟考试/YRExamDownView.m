//
//  YRExamDownView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/18.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamDownView.h"

#define  kDistance 10
@interface YRExamDownView ()
{
    NSDictionary *answerDic;
}
@property (nonatomic, weak) UIView *backView;
@property (nonatomic, weak) UILabel *anayLabel;
@property (nonatomic, weak) UILabel *answerLabel;
@end
@implementation YRExamDownView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        answerDic = @{@"1":@"A",// A
                      @"2":@"B",// B
                      @"3":@"A,B",//A,B
                      @"4":@"C",//C
                      @"5":@"A,C",//A,C
                      @"6":@"B,C",//B,C
                      @"7":@"A,B,C",//A,B,C
                      @"8":@"D",//D
                      @"9":@"A,D",//A,D
                      @"10":@"B,D",//B,D
                      @"11":@"A,B,D",//A,B,D
                      @"12":@"C,D",//C,D
                      @"13":@"A,C,D",//A,C,D
                      @"14":@"B,C,D",//B,C,D
                      @"15":@"A,B,C,D",//A,B,C,D
                      };
        [self buildUI];
    }
    return self;
}
-(void)buildUI
{
    UIView *backview = [[UIView alloc]init];
    backview.backgroundColor = kCOLOR(250, 251, 251);
    [self addSubview:backview];
    _backView = backview;
    
    UILabel *anaylabel = [[UILabel alloc]init];
    anaylabel.numberOfLines = 0;
    anaylabel.textColor = kCOLOR(60, 61, 62);
    anaylabel.font = kFontOfLetterBig;
    [_backView addSubview:anaylabel];
    _anayLabel = anaylabel;
    
    UILabel *answerlabel = [[UILabel alloc]init];
    answerlabel.font = kFontOfLetterBig;
    answerlabel.textColor = kCOLOR(60, 61, 62);
    [_backView addSubview:answerlabel];
    _answerLabel = answerlabel;
}
-(void)setAnayString:(NSString *)anayString
{
    _anayString = anayString;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(self.width-2*kDistance, MAXFLOAT)];
    _answerLabel.frame = CGRectMake(kDistance, kDistance, self.width-4*kDistance, answerSize.height);
    _answerLabel.text = @"答案：正确";
    
    NSString *analyseMsg = [NSString stringWithFormat:@"解析：%@",@"拉克丝的减肥啦手机登陆高价收购的离开家阿里；加疯了快接啊收到了；发送过来；卡；诶见gas离开房间艾丝凡看见了的法律是京东方拉斯加咖喱块十几个IE阿斯顿"];
    CGSize analyseSize = [analyseMsg sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(_answerLabel.width, MAXFLOAT)];
    _anayLabel.frame = CGRectMake(kDistance, CGRectGetMaxY(_answerLabel.frame), analyseSize.width, analyseSize.height);
    _anayLabel.text = analyseMsg;
    
    _backView.frame = CGRectMake(kDistance, 0, kScreenWidth-2*kDistance, CGRectGetMaxY(_anayLabel.frame)+kDistance);
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderColor = kCOLOR(204, 204, 206).CGColor;
    _backView.layer.borderWidth = 0.7;
}
+(CGFloat)examDownViewGetHeight:(NSString *)analyseString
{
    CGFloat height = kDistance;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-4*kDistance, MAXFLOAT)];
    height+=answerSize.height;
    
    CGSize analyseSize = [[NSString stringWithFormat:@"解析：%@",@"拉克丝的减肥啦手机登陆高价收购的离开家阿里；加疯了快接啊收到了；发送过来；卡；诶见gas离开房间艾丝凡看见了的法律是京东方拉斯加咖喱块十几个IE阿斯顿"] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(answerSize.width, MAXFLOAT)];
    height+=analyseSize.height;
    height+=kDistance;
    
    return height;
}
-(void)setQuestOb:(YRQuestionObj *)questOb
{
    _questOb = questOb;
    NSString *anserString;
    if (questOb.option.count ==4 ) {//选择题
        anserString = [NSString stringWithFormat:@"答案：%@",answerDic[[NSString stringWithFormat:@"%ld",questOb.answer]]];
    }else{
        anserString = questOb.answer-1 ? @"答案：错误":@"答案：正确";
    }
    CGSize answerSize = [anserString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(self.width-2*kDistance, MAXFLOAT)];
    _answerLabel.frame = CGRectMake(kDistance, kDistance, self.width-4*kDistance, answerSize.height);
    _answerLabel.text = anserString;
    
    NSString *analyseMsg = [NSString stringWithFormat:@"解析：%@",questOb.analy];
    CGSize analyseSize = [analyseMsg sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(_answerLabel.width, MAXFLOAT)];
    _anayLabel.frame = CGRectMake(kDistance, CGRectGetMaxY(_answerLabel.frame), analyseSize.width, analyseSize.height);
    _anayLabel.text = analyseMsg;
    
    _backView.frame = CGRectMake(kDistance, 0, kScreenWidth-2*kDistance, CGRectGetMaxY(_anayLabel.frame)+kDistance);
    _backView.layer.masksToBounds = YES;
    _backView.layer.borderColor = kCOLOR(220, 221, 222).CGColor;
    _backView.layer.borderWidth = 1;
    
    
}
+(CGFloat)examDownViewHeight:(YRQuestionObj *)analyseString
{
    CGFloat height = kDistance;
    
    CGSize answerSize = [@"答案：正确" sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-4*kDistance, MAXFLOAT)];
    height+=answerSize.height;
    
    CGSize analyseSize = [[NSString stringWithFormat:@"解析：%@",analyseString.analy] sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(answerSize.width, MAXFLOAT)];
    height+=analyseSize.height;
    height+=kDistance;
    
    return height;
}
@end
