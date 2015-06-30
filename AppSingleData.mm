//
//  AppSingleData.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppSingleData.h"

@implementation AppSingleData

- (void)setLogin:(BOOL)isLogin
{
    _isLogin=isLogin;
}


- (BOOL)getLogin
{
    return _isLogin;
}


- (void)loadBMKManager
{
    _bmkManager=[[BMKMapManager alloc]init];
    BOOL ret=[_bmkManager start:@"TTwNupNcAhtyQoKuBf1fi3Aw" generalDelegate:nil];
    if (ret==FALSE) {
        NSLog(@"地图启动失败");
    }
    else{
        NSLog(@"地图启动成功");
    }
}



+ (id)getSharedAppSingleData
{
    static AppSingleData* sington=nil;
    if (sington==nil) {
        sington=[[AppSingleData alloc]init];
    }
    return sington;
}



@end
