//
//  VCBigImageView.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCBigImageView.h"


@interface VCBigImageView ()

@end

@implementation VCBigImageView

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
    _iView=[[UIImageView alloc]init];
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(tapAct)];
    
    
    _SV=[[UIScrollView alloc]init];
    _SV.frame=CGRectMake(0, 20, 320, 460);
    [_SV addSubview:_iView];
    [_SV addGestureRecognizer:tap];
    
    
    ASIHTTPRequest* request=[[ASIHTTPRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.93.230/appPHP/%@",_strUrl]]];
    request.delegate=self;
    [request setRequestMethod:@"GET"];
    [request startAsynchronous];
    
    [self.view addSubview:_SV];
}

- (void)tapAct
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"大图开始下载");
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"大图下载完成");
    UIImage* image=[UIImage imageWithData:request.responseData];
    _iView.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    _iView.image=image;
    _SV.contentSize=_iView.bounds.size;
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
