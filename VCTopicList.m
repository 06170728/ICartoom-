//
//  VCTopicList.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCTopicList.h"

#import "VCBigImageView.h"
#import "VCTopicAdd.h"
#import "TopicListCell.h"
#import "TopicListCellModel.h"

#import "AppConst.h"

@interface VCTopicList ()

@end

@implementation VCTopicList

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
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    _btnMore = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(pressMore)];
    
    _btnAddTopic = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressAdd)];
    
    NSArray* array = [NSArray arrayWithObjects:_btnAddTopic,_btnMore, nil];
    self.navigationItem.rightBarButtonItems = array;
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    
    [self.view addSubview:_tableView];
    _arrayData=[[NSMutableArray alloc]init];
    _actView =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self downloadList];
    _connectArr=[[NSMutableArray alloc]init];
    
}



- (void)pressMore
{
    [self downloadList];
}

- (void)downloadList
{
    [_arrayData removeAllObjects];
    NSString* strURL=[NSString stringWithFormat:GetLatest_URL,10];
    
    ASIHTTPRequest* request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:strURL]];
    [request setRequestMethod:@"GET"];
    request.delegate=self;
    request.tag=100;
    [_connectArr addObject:request];
    
    [request startAsynchronous];
    
    
    _actView.center=CGPointMake(160, 230);
    [_actView startAnimating];
    [self.view addSubview:_actView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
    for (ASIHTTPRequest* request in _connectArr) {
        request.delegate=nil;
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicListCellModel* model=[_arrayData objectAtIndex:indexPath.row];
    NSString* strUrl=model.strBigImage;
    VCBigImageView* bigView=[[VCBigImageView alloc]init];
    bigView.strUrl=strUrl;
    
    [self presentViewController:bigView animated:YES completion:nil];
}



-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"开始更新列表信息");
}



-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==100) {
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
        NSArray* array=[dic objectForKey:@"topics"];
        for (NSDictionary* dic in array) {
            TopicListCellModel* cellModel=[[TopicListCellModel alloc]init];
            
            //大图
            NSString* strBigImage=[dic objectForKey:@"imagepath"];
            NSString* strId=[dic objectForKey:@"id"];
        
            //小图
            ASIHTTPRequest* requestSmallImage=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.93.230/appPHP/%@%@",strBigImage,@"_small"]]];
            requestSmallImage.delegate=self;
            requestSmallImage.tag=[strId intValue];
            [requestSmallImage setRequestMethod:@"GET"];
            
            [_connectArr addObject:requestSmallImage];
            
            cellModel.mTag=requestSmallImage.tag;
   
            cellModel.strBigImage=strBigImage;
            
            
            //标题
            NSString* strTitle=[dic objectForKey:@"title"];
            cellModel.mTitle=strTitle;
            
            //发表日期
            NSString* strDate=[dic objectForKey:@"postdate"];
            cellModel.mPostDate=strDate;
            
            //作者
            NSString* strAuthor=[dic objectForKey:@"author"];
            cellModel.mAuthor=strAuthor;
            
            [_arrayData addObject:cellModel];
            
            [requestSmallImage startAsynchronous];
        }
        
    }
    else
    {
        for (TopicListCellModel* model in _arrayData) {
            if (model.mTag==request.tag) {
                UIImage* image=[UIImage imageWithData:request.responseData];
                model.mImage=image;
                break;
            }
        }
    }
    
    [_actView stopAnimating];
    [_tableView reloadData];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ID";
    TopicListCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"TopicListCell" owner:self options:nil][0];
    }
    TopicListCellModel* model=[_arrayData objectAtIndex:indexPath.row];
    
    cell.model=model;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicListCellModel* model=[_arrayData objectAtIndex:indexPath.row];
    return [model getCellHeight];
}



- (void)pressAdd
{
    //照片选择控制器
    //会读取系统照片app中的所有照片
    UIImagePickerController* pickerImage = [[UIImagePickerController alloc]init];
    pickerImage.delegate = self;
    
    //使用照片库中的文件作为数据源
    pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pickerImage animated:YES completion:nil];
}




//选中照片后调用此协议函数
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //获取
    //info表示返回的数据
    //通过image的key 来获取图片,返回值为图片指针
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        VCTopicAdd* topicAdd = [[VCTopicAdd alloc]init];
        topicAdd.mMainImage = image;
        [self.navigationController pushViewController:topicAdd animated:YES];
    }];
}

//当按下取消按钮时调用此函数
//参数为照片控制器本身
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.tabBarController.tabBar.hidden=NO;
    [picker dismissViewControllerAnimated:YES completion:nil];
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
