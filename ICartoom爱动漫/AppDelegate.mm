//
//  AppDelegate.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "AppDelegate.h"

#import "VCCategory.h"
#import "VCMe.h"
#import "VCRoot.h"
#import "VCDiscovery.h"
#import "AppSingleData.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [self loadVC];
    
    AppSingleData* sinton=[AppSingleData getSharedAppSingleData];
    [sinton loadBMKManager];
    
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBK"]];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)loadVC
{
    NSArray* arrayClassName=[NSArray arrayWithObjects:@"VCCategory",@"VCMe",@"VCDiscovery", nil];
    NSArray* arrayTitle=[NSArray arrayWithObjects:@"动漫",@"登录",@"周围", nil];
    NSMutableArray* arrayVC=[[NSMutableArray alloc]init];
    
    for (int i=0;i<arrayClassName.count;i++) {
        
        Class class1=NSClassFromString(arrayClassName[i]);
        
        UIViewController* vc=(UIViewController*)[[class1 alloc]init];
        
        UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:vc];
        vc.title=arrayTitle[i];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"btnBK"] forBarMetrics:UIBarMetricsDefault];
        [nav.navigationBar setTintColor:[UIColor whiteColor]];
        [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:20],NSFontAttributeName,nil]];
        [arrayVC addObject:nav];
    }
    
    UITabBarController* tabVC=[[UITabBarController alloc]init];
    tabVC.viewControllers=arrayVC;
    self.window.rootViewController=tabVC;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
