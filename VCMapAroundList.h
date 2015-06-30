//
//  VCMapAroundList.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BMapKit.h"


@interface VCMapAroundList : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    
    BMKPoiSearch* _searchEngine;
}


@end
