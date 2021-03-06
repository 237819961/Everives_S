//
//  YRLearnNoMsgView.h
//  Everives_S
//
//  Created by 李洪攀 on 16/3/22.
//  Copyright © 2016年 darkclouds. All rights reserved.
//
@protocol YRLearnNoMsgViewDelegate <NSObject>

-(void)learnNoMsgViewAttestationClickTag:(NSInteger)btnTag;

@end
#import <UIKit/UIKit.h>

@interface YRLearnNoMsgView : UIView

@property (nonatomic, strong)NSString *btnTitle;

@property (nonatomic, assign) id<YRLearnNoMsgViewDelegate>delegate;

@end
