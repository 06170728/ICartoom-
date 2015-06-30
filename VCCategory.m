//
//  VCCategory.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCCategory.h"
#import "VCTopicList.h"

@interface VCCategory ()

@end

@implementation VCCategory

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
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc]init];
    
    [self loadLocalData];
}

- (void)loadLocalData
{
    NSString* strPath = [[NSBundle mainBundle]pathForResource:@"categorylist" ofType:@"plist"];
    NSArray* arrayP = [NSArray arrayWithContentsOfFile:strPath];
    
    for (NSDictionary* dic in arrayP) {
        NSMutableArray* arrayGroup=[[NSMutableArray alloc]init];
        NSString* gName=[dic objectForKey:@"groupName"];
        NSArray* arrayTitles=[dic objectForKey:@"Items"];
        
        [arrayGroup addObject:gName];
        [arrayGroup addObjectsFromArray:arrayTitles];
        
        [_arrayData addObject:arrayGroup];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VCTopicList* topickList=[[VCTopicList alloc]init];
    NSArray* arrayG=[_arrayData objectAtIndex:indexPath.section];
    NSString* title=[arrayG objectAtIndex:indexPath.row+1];
    topickList.title=title;
    [self.navigationController pushViewController:topickList animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayData.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* arrayG=[_arrayData objectAtIndex:section];
    return arrayG.count-1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ID";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    NSArray* arrayG=[_arrayData objectAtIndex:indexPath.section];
    NSString* title=[arrayG objectAtIndex:indexPath.row+1];
    cell.textLabel.text=title;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    return cell;
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray* arrayG=[_arrayData objectAtIndex:section];
    return arrayG[0];
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
