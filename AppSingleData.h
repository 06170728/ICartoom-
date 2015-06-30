//
//  AppSingleData.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMapKit.h"

@interface AppSingleData : NSObject
{
    //是否已启动
    BOOL _isLogin;
    //地图引擎
    BMKMapManager* _bmkManager;
}
- (void)setLogin:(BOOL)isLogin;
- (BOOL)getLogin;
- (void)loadBMKManager;

+ (id)getSharedAppSingleData;

@end
