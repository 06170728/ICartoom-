//
//  VCMe.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCMe.h"
#import "VCLogin.h"

@interface VCMe ()

@end

@implementation VCMe

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
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _isLogin=NO;
    
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc]init];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (_isLogin == YES) {
            UIAlertView* alertV=[[UIAlertView alloc]initWithTitle:@"提示" message:@"退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            [alertV show];
        }
        else
        {
            VCLogin* login=[[VCLogin alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
}





-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        _isLogin= NO;
    }
    
    [_tableView reloadData];
}




-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* strID=@"ID";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:strID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }

    if (_isLogin == YES) {
        cell.textLabel.text = @"退出登录";
    }
    else
    {
        cell.textLabel.text = @"登录";
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    return cell;
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
