//
//  VCMapWalkLine.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface VCMapWalkLine : UIViewController <BMKMapViewDelegate>
{
    BMKMapManager* _BMKManager;
    
    //视图对象
    //默认单例模式
    BMKMapView* _bMapView;
    
    //路线搜索对象
//    BMKRouteSearchType* _bRouteSearch;
}
@end
