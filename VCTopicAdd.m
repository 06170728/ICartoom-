//
//  VCTopicAdd.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCTopicAdd.h"
#import "AppConst.h"

@interface VCTopicAdd ()

@end

@implementation VCTopicAdd

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
 
    
    _btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnSend.frame = CGRectMake(260, 5, 60, 40);
    [_btnSend setTitle:@"发送" forState:UIControlStateNormal];
    [_btnSend addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
    _btnSend.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"btnBK"]];
    _btnSend.layer.cornerRadius=5;
    _btnSend.tintColor=[UIColor whiteColor];
    [self.view addSubview:_btnSend];
    
    UITextField* mTFTitle = [[UITextField alloc]init];
    mTFTitle.frame = CGRectMake(5, 5, 250, 40);
    mTFTitle.delegate = self;
    mTFTitle.borderStyle=UITextBorderStyleRoundedRect;
    mTFTitle.tag = 101;
    mTFTitle.placeholder=@"输入主题....";
    mTFTitle.delegate=self;
    [self.view addSubview:mTFTitle];
    
    _SV=[[UIScrollView alloc]init];
    _SV.frame=CGRectMake(5, 50, 310, 327);
    
    UIImageView* imageView = [[UIImageView alloc]init];
    if (_mMainImage.size.width>310) {
        float ratio=_mMainImage.size.width/320;
        imageView.frame = CGRectMake(0, 0, 310, _mMainImage.size.height/ratio);
        _SV.contentSize=CGSizeMake(310, _mMainImage.size.height/ratio);
    }
    
    else
    {
        imageView.frame = CGRectMake(0, 0, _mMainImage.size.width, _mMainImage.size.height);
        
        _SV.contentSize=CGSizeMake(_mMainImage.size.width, _mMainImage.size.height);
    }
    
    imageView.image = _mMainImage;
    [_SV addSubview:imageView];
    [self.view addSubview:_SV];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (UIImage*)getSmallImage:(UIImage*)originImage withSize:(CGSize)size
{
    //创建一个画布对象
    UIGraphicsBeginImageContext(size);
    
    //将原始图像绘制到画布中
    //画布大小由参数决定
    [originImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    //从画布中获得对象
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭画布对象
    UIGraphicsEndImageContext();
    return image;
}


- (void)uploadDate
{
    //压缩原始图像
    //只负责压缩算法,不会变更图像尺寸
    NSData* bigImageData=UIImageJPEGRepresentation(_mMainImage, 0.7);
    float fRatio=_mMainImage.size.width/160;
    
    
    //计算小图片大小
    
    CGSize sizeSmall;
    sizeSmall.width=_mMainImage.size.width/fRatio;
    sizeSmall.height=_mMainImage.size.height/fRatio;
    
    //0.5压缩比:%30~40%空间
    //0.5-1.0肉眼不宜分辨
    UIImage* sImage=[self getSmallImage:_mMainImage withSize:sizeSmall];
    
    NSData* sData=UIImageJPEGRepresentation(sImage, 0.5);

    
    int page=1;
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:UpLoad_URL,page]];
    ASIFormDataRequest* request = [[ASIFormDataRequest alloc]initWithURL:url];
    request.delegate = self;
    
    [request setPostValue:@"89757" forKey:@"UNAME"];
    [request setPostValue:@"1001" forKey:@"ID"];
    
    
    UITextField* tf = (UITextField*)[self.view viewWithTag:101];
    NSString* title = tf.text;
    [request setPostValue:title forKey:@"TITLE"];
    [request setPostValue:@"我的内容" forKey:@"TEXT"];
    
    //小图
    [request setData:sData withFileName:@"small.png" andContentType:@"image/jpg" forKey:@"file02"];
    
    //大图
    [request setData:bigImageData withFileName:@"big.png" andContentType:@"image/jpg" forKey:@"file"];
    
    [request setRequestMethod:@"POST"];
    
    [request buildPostBody];
    [request startAsynchronous];
}


- (void)pressSend
{
    [self uploadDate];
}





- (void)pressBack
{
    NSLog(@"即将取消发送");
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"开始上传");
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"上传失败");
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSDictionary* dic =[NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
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
