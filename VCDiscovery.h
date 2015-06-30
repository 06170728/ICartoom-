//
//  VCDiscovery.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCDiscovery : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
}

@end
