//
//  VCMe.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCMe : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray* _arrayData;
    UITableView* _tableView;
    BOOL _isLogin;
}
@end
