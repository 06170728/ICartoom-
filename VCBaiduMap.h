//
//  VCBaiduMap.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface VCBaiduMap : UIViewController<BMKMapViewDelegate,UISearchBarDelegate>
{
    BMKMapManager* _bmkManager;
    BMKMapView* _bmkMapView;
    UISearchBar* _searchBar;
}

@property (retain,nonatomic)NSMutableArray* annoArr;
@property (assign,nonatomic)float longitude;
@property (assign,nonatomic)float latitude;
@end
