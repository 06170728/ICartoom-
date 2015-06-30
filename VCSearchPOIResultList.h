//
//  VCSearchPOIResultList.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"


@interface VCSearchPOIResultList : UIViewController <BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UIGestureRecognizerDelegate>
{
    //搜索对象
    BMKPoiSearch* _bmkSearch;
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    BMKMapManager* _bmkManager;
   
}



@end
