//
//  YRCircleToolBar.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRCircleToolBar.h"
#import "YRWeibo.h"
#import "RequestData.h"
#define CZStatusCellMargin 10
#define CZNameFont [UIFont systemFontOfSize:13]
#define CZTimeFont [UIFont systemFontOfSize:12]
#define CZSourceFont CZTimeFont
#define CZTextFont [UIFont systemFontOfSize:15]
#define CZScreenW [UIScreen mainScreen].bounds.size.width
@interface YRCircleToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, weak) UILabel *address;//地址
@property (nonatomic, weak) UIButton *comment;//评论
@property (nonatomic, weak) UIButton *unlike;//赞

@end

@implementation YRCircleToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        //        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
//                self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)setUpAllChildView
{
    // 转发
    UILabel *address = [[UILabel alloc] init];
    address.font = CZNameFont;
    address.textColor = kCOLOR(153, 153, 153);
    [self addSubview:address];
    _address = address;
    
    // 评论
    UIButton *comment = [self setUpOneButtonWithTitle:@"评论" image:[UIImage imageNamed:@"SNS_Comment"]];
    [comment addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    comment.tag = 21;
    _comment = comment;
    
    // 赞
    UIButton *unlike = [self setUpOneButtonWithTitle:@"赞" image:[UIImage imageNamed:@"SNS_unLike"]];
    [unlike setImage:[UIImage imageNamed:@"SNS_Likes"] forState:UIControlStateSelected];
    [unlike addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    unlike.tag = 22;
    _unlike = unlike;
}
- (UIButton *)setUpOneButtonWithTitle:(NSString *)title image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:kCOLOR(153, 153, 153) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat addressX = CZStatusCellMargin;
    CGFloat addressY = 0;
    CGFloat addressH = self.height;
    CGFloat addressW = (CZScreenW - 2*CZStatusCellMargin)/2;
    self.address.frame = CGRectMake(addressX, addressY, addressW, addressH);
    
    // 设置按钮的frame
    CGFloat w = (CZScreenW - 2*CZStatusCellMargin) / 5;
    CGFloat h = self.height;
    CGFloat x = CGRectGetMaxX(self.address.frame);
    CGFloat y = 0;
    
    self.unlike.frame = CGRectMake(x+2*CZStatusCellMargin, y, w, h);
    self.comment.frame = CGRectMake(CGRectGetMaxX(self.unlike.frame), y, w, h);
}
-(void)setStatus:(YRWeibo *)status
{
    _status = status;
    
    // 设置转发的标题
    _address.text = status.address;
    
    // 设置评论的标题
    [self setBtn:_comment title:[status.commentCount intValue]];
    
    // 设置赞
    [self setBtn:_unlike title:[status.praise intValue]];
    
    self.unlike.selected = [status.praised boolValue];
}
// 设置按钮的标题
- (void)setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1fW",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else{ // < 10000
            title = [NSString stringWithFormat:@"%d",count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"0" forState:UIControlStateNormal];
    }
}
-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 22) {
        if ([_status.praised boolValue]) {
            [RequestData DELETE:[NSString stringWithFormat:@"/seeds/praise/%@",_status.id] parameters:nil complete:^(NSDictionary *responseDic) {
                [self.delegate commentOrAttentTouch:sender.tag-20];
            } failed:^(NSError *error) {
                
            }];
        }else{
            [RequestData POST:WEIBO_PRAISE parameters:@{@"id":_status.id} complete:^(NSDictionary *responseDic) {
                [self.delegate commentOrAttentTouch:sender.tag-20];
            } failed:^(NSError *error) {
                
            }];
        }
        
    }else
        [self.delegate commentOrAttentTouch:sender.tag-20];
}
@end