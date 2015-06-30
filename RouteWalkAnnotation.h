//
//  RouteWalkAnnotation.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "BMKPointAnnotation.h"

enum RouteWalkAnnoType
{
    RouteWalkAnnoType_Start=1,
    RouteWalkAnnoType_End,
    RouteWalkAnnoType_Mid
};

@interface RouteWalkAnnotation : BMKPointAnnotation
///锚点类型 1:起点  2:终点  3:路点
@property (assign,nonatomic) int annoType;
@end
