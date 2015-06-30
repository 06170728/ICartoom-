//
//  AppDelegate.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
     BMKMapManager* _bmkManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
