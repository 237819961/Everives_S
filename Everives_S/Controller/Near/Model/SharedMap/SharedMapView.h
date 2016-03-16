//
//  SharedMapView.h
//  officialDemoNavi
//
//  Created by 刘博 on 15/5/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface SharedMapView : NSObject<MAMapViewDelegate>

@property (nonatomic, readonly) MAMapView *mapView;

+ (instancetype)sharedInstance;

@end