//
//  YRSchoolAnnotationCalloutView.m
//  SkyFish
//
//  Created by darkclouds on 15/11/20.
//  Copyright © 2015年 SkyFish. All rights reserved.
//
#import "UIImageView+WebCache.h"
#import "YRSchoolAnnotationCalloutView.h"
#import "DistanceToolFuc.h"
#import "YRSchoolModel.h"
#import "YRPictureModel.h"
#import "YRStarsView.h"
#define kArrorHeight        10

@interface YRSchoolAnnotationCalloutView ()
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) YRStarsView *stars;
@property(nonatomic,strong) UILabel *address;
@property(nonatomic,strong) UILabel *distance;

@end
@implementation YRSchoolAnnotationCalloutView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)buildUI{
    [self addSubview:self.imageView];
    [self addSubview:self.name];
    [self addSubview:self.stars];
    [self addSubview:self.address];
    [self addSubview:self.distance];
}
//绘制calloutView的背景
- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

#pragma mark  - Getters
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8.5, 7, 90, 90)];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_imageurl] placeholderImage:[UIImage imageNamed:kPLACEHHOLD_IMG]];
    }
    return _imageView;
}
-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] initWithFrame:CGRectMake(106, 8, 110, 20)];
        _name.font = kFontOfLetterBig;
        _name.text = _namestr;
    }
    return _name;
}
-(YRStarsView *)stars{
    if (!_stars) {
        _stars = [[YRStarsView alloc] initWithFrame:CGRectMake(103, 24, 100, 30) score:[_scorestr integerValue] starWidth:21 intervel:0 needLabel:YES];
        _stars.label.textColor = kCOLOR(177, 178, 179);
    }
    return _stars;
}
-(UILabel *)address{
    if (!_address) {
        _address = [[UILabel alloc] initWithFrame:CGRectMake(106, 52, 115, 20)];
        _address.font = kFontOfLetterMedium;
        _address.textColor = kYRBlackTextColor;
        _address.text = _addrstr;
    }
    return _address;
}
-(UILabel *)distance{
    if (!_distance) {
        _distance = [[UILabel alloc] initWithFrame:CGRectMake(106, 75, 110, 20)];
        _distance.font = kFontOfLetterMedium;
        _distance.text = _distancestr?[NSString stringWithFormat:@"距离%@",_distancestr]:@"距离未知";
        _distance.textColor = kTextlightGrayColor;
    }
    return _distance;
}

@end
