//
//  YRExamHeadView.m
//  Everives_S
//
//  Created by 李洪攀 on 16/3/17.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRExamHeadView.h"
#import "UIImageView+WebCache.h"
#import "CYVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#define kDistance 20
@interface YRExamHeadView ()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) CYVideoPlayerView *playerView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UIView *topLine;
@end
@implementation YRExamHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self buildUI];
        
    }
    return self;
}
-(void)buildUI
{
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.numberOfLines = 0;
    titlelabel.font = kFontOfLetterBig;
    titlelabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titlelabel];
    _titleLabel = titlelabel;
    
    UIImageView *imgview = [[UIImageView alloc]init];
    imgview.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imgview];
    _imgView = imgview;
    
    UIView *topline = [[UIView alloc]init];
    topline.backgroundColor = kCOLOR(241, 241, 241);
    [self addSubview:topline];
    _topLine = topline;
    
    CYVideoPlayerView *playerview = [[CYVideoPlayerView alloc]init];
    [self addSubview:playerview];
    _playerView = playerview;
}
-(void)setMNCurrentID:(NSInteger)MNCurrentID
{
    _MNCurrentID = MNCurrentID;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",MNCurrentID,_ques.content];
    _titleLabel.text = titleString;
}
-(void)setQues:(YRQuestionObj *)ques
{
    _ques = ques;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    _titleLabel.frame = CGRectMake(kDistance, kDistance, titleSize.width, titleSize.height);
    _titleLabel.text = titleString;
    
    if (ques.pics.length) {
        if ([ques.pics containsString:@"mp4"]) {//视频播放
            _playerView.frame = CGRectMake(kDistance*2, CGRectGetMaxY(_titleLabel.frame)+kDistance, kScreenWidth-4*kDistance, (kScreenWidth-4*kDistance)/2);
            [_playerView replaceAVPlayerItem:[[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:ques.pics]]];
            _playerView.hidden = NO;
            _topLine.frame = CGRectMake(0, CGRectGetMaxY(_playerView.frame)+kDistance-1, kScreenWidth, 1);
        }else{
            _imgView.frame = CGRectMake(kDistance*2, CGRectGetMaxY(_titleLabel.frame)+kDistance, kScreenWidth-4*kDistance, (kScreenWidth-4*kDistance)/2);
            [_imgView sd_setImageWithURL:[NSURL URLWithString:ques.pics] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
            _imgView.hidden = NO;
            _topLine.frame = CGRectMake(0, CGRectGetMaxY(_imgView.frame)+kDistance-1, kScreenWidth, 1);

        }
    }else{
        _playerView.hidden = YES;
        [_playerView removeVideo];
        _imgView.hidden = YES;
        _topLine.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+kDistance-1, kScreenWidth, 1);
    }
}
+(CGFloat)examHeadViewHeight:(YRQuestionObj *)ques
{
    CGFloat height;
    height = kDistance*2;
    NSString *titleString = [NSString stringWithFormat:@"%ld、%@",ques.id,ques.content];
    CGSize titleSize = [titleString sizeWithFont:kFontOfLetterBig maxSize:CGSizeMake(kScreenWidth-2*kDistance, MAXFLOAT)];
    if (ques.pics.length) {
        height+= (kScreenWidth-4*kDistance)/2;
        height+=kDistance;
    }
    height+=titleSize.height;
    return height;
}
@end
