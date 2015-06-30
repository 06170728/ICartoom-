//
//  VCMapWalkLine.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-18.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCMapWalkLine.h"
#import "RouteWalkAnnotation.h"

@interface VCMapWalkLine ()

@end

@implementation VCMapWalkLine


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
    return;
    
//    [self loadBMKManager];
    _bMapView=[[BMKMapView alloc]initWithFrame:self.view.bounds];
    _bMapView.delegate=self;
    BMKCoordinateSpan span=BMKCoordinateSpanMake(0.01, 0.01);
    CLLocationCoordinate2D center=CLLocationCoordinate2DMake(31.277, 121.523);
    
    BMKCoordinateRegion region=BMKCoordinateRegionMake(center, span);
    [_bMapView setRegion:region];
    
    //    能够在地图上进行显示的提示信息点坐标,在地图中心坐标会添加一个,锚点
    BMKPointAnnotation* pointAnno=[[BMKPointAnnotation alloc]init];
    pointAnno.coordinate=center;
    pointAnno.title=@"阿大SD";
    
    [_bMapView addAnnotation:pointAnno];
    
    UIBarButtonItem* btn=[[UIBarButtonItem alloc]initWithTitle:@"开始路线" style:UIBarButtonItemStyleBordered target:self action:@selector(pressAct)];
    self.navigationItem.rightBarButtonItem=btn;
    
    
    [self.view addSubview:_bMapView];
}

/*

- (void)pressAct
{
    BMKPlanNode* startNode=[[BMKPlanNode alloc]init];
    startNode.name=@"双辽路17号";
    startNode.cityName=@"上海市";
    
    BMKPlanNode* endNode=[[BMKPlanNode alloc]init];
    endNode.name=@"江浦路地铁站";
    endNode.cityName=@"上海市";
    
    _bRouteSearch=[[BMKRouteSearch alloc]init];
    _bRouteSearch.delegate=self;
    
    //创建一个路线类型
    //步行路线
    //公交路线
    //驾车路线
    BMKWalkingRoutePlanOption* option=[[BMKWalkingRoutePlanOption alloc]init];
    option.from=startNode;
    option.to=endNode;
    
    //启动步行路线搜索
    [_bRouteSearch walkingSearch:option];
}

-(void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    
}

-(void)onGetTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    
}


//锚点视图协议
//当设置锚点对象时,要显示锚点时调用此协议函数
//参数一:mapview
//参数二:锚点位置信息
//返回一个锚点视图,进行图像视图的修改
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    if (![annotation isKindOfClass:[RouteWalkAnnotation class]]) {
        return nil;
    }
    
    
    BMKAnnotationView* newView=[[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"11"];
    newView.canShowCallout=YES;
    
    //获得锚点信息
    RouteWalkAnnotation* rAnno=(RouteWalkAnnotation*)annotation;
    
    if (rAnno.annoType==RouteWalkAnnoType_Start) {
        newView.image=[UIImage imageNamed:@"icon_nav_start.png"];
    }
    else if (rAnno.annoType==RouteWalkAnnoType_End)
    {
        newView.image=[UIImage imageNamed:@"icon_nav_end.png"];
    }
    else if (rAnno.annoType==RouteWalkAnnoType_Mid)
    {
        newView.image=[UIImage imageNamed:@"icon_nav_waypoint.png"];
    }
    
    //设置距离锚点的偏移量
    newView.centerOffset=CGPointMake(0, -5);
    
    //将视图关联到锚点坐标上
    newView.annotation=rAnno;
    
    return newView;
}

//当需要在地图上绘制图像,线段等图形时,调用
//返回值为可以显示到map上的绘图视图
//参数2:为Overlay(图层)协议对象
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* vView=[[BMKPolylineView alloc]initWithOverlay:overlay];
        //只改变颜色的透明度
        //填充颜色
        vView.fillColor=[[UIColor cyanColor]colorWithAlphaComponent:1.0];
        //边框线颜色
        vView.strokeColor=[[UIColor blueColor]colorWithAlphaComponent:0.7];
        vView.lineWidth=3.0;
        return vView;
    }
    return nil;
}




-(void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    //删除锚点
    NSArray* arrayAnno=[NSArray arrayWithArray:_bMapView.annotations];
    [_bMapView removeAnnotations:arrayAnno];
    
    //删除overlay图层对象
    NSArray* arrayOverlay=[NSArray arrayWithArray:_bMapView.overlays];
    [_bMapView removeOverlays:arrayOverlay];
    
    
    if (error==BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan=result.routes[0];
        NSArray* steps=plan.steps;
        NSLog(@"num=%d",steps.count);
        
        int pointCount=0;
        for (int i=0; i<steps.count; i++) {
            BMKWalkingStep* step=[steps objectAtIndex:i];
            
            
            RouteWalkAnnotation* midPT=[[RouteWalkAnnotation alloc]init];
            midPT.coordinate=step.entrace.location;
            midPT.title=step.instruction;
            midPT.annoType=RouteWalkAnnoType_Mid;
            [_bMapView addAnnotation:midPT];
            
            
            if (i==0)
            {
                RouteWalkAnnotation* startPT=[[RouteWalkAnnotation alloc]init];
                startPT.coordinate=plan.starting.location;
                startPT.title=@"起点";
                startPT.annoType=RouteWalkAnnoType_Start;
                [_bMapView addAnnotation:startPT];
            }
            
            else if (i==steps.count-1)
            {
                RouteWalkAnnotation* endPT=[[RouteWalkAnnotation alloc]init];
                endPT.coordinate=plan.terminal.location;
                endPT.title=@"结束点";
                endPT.annoType=RouteWalkAnnoType_End;
                [_bMapView addAnnotation:endPT];
            }
            
            
            //添加绘图线段的点数
            pointCount+=step.pointsCount;
            
            NSLog(@"-----%d",step.pointsCount);
        }
        
        
        //pointsLine[pointCount]  含x,y结构体数组
        BMKMapPoint pointsLine[pointCount];
        int k=0;
        
        //steps
        for (int i=0; i<steps.count; i++) {
            BMKWalkingStep* step=[steps objectAtIndex:i];
            for (int j=0; j<step.pointsCount; j++) {
                pointsLine[k].x=step.points[j].x;
                pointsLine[k].y=step.points[j].y;
                k++;
            }
        }
        
        BMKPolyline* pline=[BMKPolyline polylineWithPoints:pointsLine count:pointCount];
        [_bMapView addOverlay:pline];
    }
    
}


/*
 -(void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
 {
 //重新规划路线,删除原来的标示点数据
 [_bMapView removeAnnotations:_bMapView.annotations];
 
 
 //    BMK_SEARCH_NO_ERROR =0,///<检索结果正常返回
 //    BMK_SEARCH_AMBIGUOUS_KEYWORD,///<检索词有岐义
 //    BMK_SEARCH_AMBIGUOUS_ROURE_ADDR,///<检索地址有岐义
 //    BMK_SEARCH_NOT_SUPPORT_BUS,///<该城市不支持公交搜索
 //    BMK_SEARCH_NOT_SUPPORT_BUS_2CITY,///<不支持跨城市公交
 //    BMK_SEARCH_RESULT_NOT_FOUND,///<没有找到检索结果
 //    BMK_SEARCH_ST_EN_TOO_NEAR,///<起终点太近
 
 //    NSArray* route=result.routes;
 
 //搜索第一条路线方案
 //    BMKWalkingRouteLine* plan=[route objectAtIndex:0];
 BMKWalkingRouteLine* plan=result.routes[0];
 
 //路线节点
 NSArray* steps=plan.steps;
 
 NSLog(@"steps Num=%d",steps.count);
 
 if (error == BMK_SEARCH_NO_ERROR) {
 for (int i=0; i<steps.count; i++) {
 BMKWalkingStep* step=[steps objectAtIndex:i];
 BMKPointAnnotation* pt=[[BMKPointAnnotation alloc]init];
 if (i==0) {
 pt.title=@"起始点";
 }
 else if (i==steps.count-1)
 {
 pt.title=@"结束点";
 }
 else{
 pt.title=@"路点";
 }
 pt.coordinate=step.entrace.location;
 [_bMapView addAnnotation:pt];
 }
 }
 
 }





-(void)viewWillAppear:(BOOL)animated
{
    [_bMapView viewWillAppear];
    _bMapView.delegate=self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_bMapView viewWillDisappear];
    _bMapView.delegate=nil;
}


- (void)loadBMKManager
{
    _BMKManager=[[BMKMapManager alloc]init];
    BOOL ret= [_BMKManager start:@"TTwNupNcAhtyQoKuBf1fi3Aw" generalDelegate:nil];
    if (ret) {
        NSLog(@"启动引擎成功");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/

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
