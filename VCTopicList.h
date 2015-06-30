//
//  VCTopicList.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"

@interface VCTopicList : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASIHTTPRequestDelegate>
{
    UITableView* _tableView;
    NSMutableArray* _arrayData;
    
    UIBarButtonItem* _btnMore;
    
    UIBarButtonItem* _btnAddTopic;
    
    UIActivityIndicatorView* _actView;
    
    NSMutableArray* _connectArr;
}

@end
