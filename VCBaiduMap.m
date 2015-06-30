//
//  VCBaiduMap.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCBaiduMap.h"
#import "VCSearchPOIResultList.h"
#import "VCMapWalkLine.h"

@interface VCBaiduMap ()

@end

@implementation VCBaiduMap

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _bmkMapView=[[BMKMapView alloc]init];
    _bmkMapView.frame=self.view.bounds;
    _bmkMapView.delegate=self;
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(10, 5, 300, 40)];
    _searchBar.translucent=YES;
    
    _searchBar.searchBarStyle=UISearchBarStyleMinimal;

    _searchBar.delegate=self;
    
    BMKCoordinateSpan span=BMKCoordinateSpanMake(0.1, 0.1);
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(_latitude, _longitude);
    
    BMKCoordinateRegion region=BMKCoordinateRegionMake(center, span);
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(10, 260, 50, 20);
    btn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"btnBK"]];
    btn.layer.cornerRadius=5;
    btn.tintColor=[UIColor whiteColor];
    [btn addTarget:self action:@selector(changeView) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"视图" forState:UIControlStateNormal];
    
    [_bmkMapView setRegion:region animated:YES];
    _bmkMapView.showMapScaleBar=YES;
    _bmkMapView.mapScaleBarPosition=CGPointMake(10, 300);
    _bmkMapView.compassPosition=CGPointMake(0, 100);
    
    BMKLocationViewDisplayParam* show=[[BMKLocationViewDisplayParam alloc]init];
    show.isAccuracyCircleShow=YES;
    show.locationViewImgName=@"asdas";
    [_bmkMapView updateLocationViewWithParam:show];
    
    [self.view addSubview:_bmkMapView];
    [self.view addSubview:btn];
    [self.view addSubview:_searchBar];

    UIBarButtonItem* btnWalk=[[UIBarButtonItem alloc]initWithTitle:@"步行" style:UIBarButtonItemStyleDone target:self action:@selector(walkRoute)];
    self.navigationItem.rightBarButtonItem=btnWalk;
    
    if ([_annoArr count]) {
        [_bmkMapView addAnnotations:_annoArr];
    }
}



- (void)walkRoute
{
    VCMapWalkLine* walk=[[VCMapWalkLine alloc]init];
    [self.navigationController pushViewController:walk animated:YES];
}


-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    VCSearchPOIResultList* list=[[VCSearchPOIResultList alloc]init];
    [self.navigationController pushViewController:list animated:NO];
    return YES;
}



- (void)changeView
{
    static BOOL isStandard=NO;
    if (isStandard==NO) {
         [_bmkMapView setMapType:BMKMapTypeSatellite];
    }
    else
    {
        [_bmkMapView setMapType:BMKMapTypeStandard];
    }
    
    isStandard=!isStandard;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    [_searchBar resignFirstResponder];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
