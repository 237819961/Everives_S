//
//  YRCircleUser.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/8.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRCircleUserDelegate <NSObject>

-(void)userIconClick;

@end
#import <UIKit/UIKit.h>
@class YRCircleCellViewModel;
@interface YRCircleUser : UIImageView
@property (nonatomic, assign) id<YRCircleUserDelegate>delegate;
@property (nonatomic, assign) BOOL lineBool;
@property (nonatomic, strong) YRCircleCellViewModel *statusF;
@end
