//
//  VCSearchPOIResultList.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCSearchPOIResultList.h"
#import "VCSearchPOIResultMap.h"

@interface VCSearchPOIResultList ()

@end

@implementation VCSearchPOIResultList

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
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _arrayData=[[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 465) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
 

    UISearchBar* searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    searchBar.delegate=self;
    searchBar.searchBarStyle=UISearchBarStyleMinimal;
    _tableView.tableHeaderView=searchBar;
    
    [searchBar becomeFirstResponder];
    [self.view addSubview:_tableView];
    
    // Do any additional setup after loading the view.
}




- (void)tapAct
{
    [self.view endEditing:YES];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BMKPoiInfo* info=[_arrayData objectAtIndex:indexPath.row];
    VCSearchPOIResultMap* map=[[VCSearchPOIResultMap alloc]init];
    map.longitude=info.pt.longitude;
    map.latitude=info.pt.latitude;
    map.annoArr=[[NSMutableArray alloc]init];
    
    for (BMKPoiInfo* info in _arrayData) {
        BMKPointAnnotation* pAnno=[[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coord;
        coord.longitude=info.pt.longitude;
        coord.latitude=info.pt.latitude;
        pAnno.coordinate=coord;
        pAnno.title=info.name;
        [map.annoArr addObject:pAnno];
    }
    [self.navigationController pushViewController:map animated:YES];
    NSLog(@"push");
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strId=@"ID";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:strId];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strId];
    }
    
    BMKPoiInfo* info=[_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text=info.name;

    cell.detailTextLabel.text=info.address;
    return cell;
}


-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    
     NSLog(@"列表加载完成");
    for (BMKPoiInfo* info in poiResult.poiInfoList) {
        [_arrayData addObject:info];
    }
    [_tableView reloadData];
    
    UIApplication* app=[UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:NO];

}





-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _bmkSearch=[[BMKPoiSearch alloc]init];
    BMKCitySearchOption* citySearchOption=[[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex=0;
    citySearchOption.pageCapacity=10;
    citySearchOption.city=@"上海";
    citySearchOption.keyword=searchBar.text;
    _bmkSearch.delegate=self;
    
   BOOL isRet= [_bmkSearch poiSearchInCity:citySearchOption];
    
    NSLog(@"_%@",_bmkSearch.delegate);
   
    
    if(isRet)
    {
             NSLog(@"城市内检索发送成功");
    }
    else
    {
             NSLog(@"城市内检索发送失败");
    }
    
    [self.view endEditing:YES];
    
    NSLog(@"%@",searchBar.text);
    UIApplication* app=[UIApplication sharedApplication];
    [app setNetworkActivityIndicatorVisible:YES];
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
