//
//  VCRegister.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCRegister.h"
#import "NetDownloadTS.h"

#define RegisterURL(user,password,email) [NSString stringWithFormat:@"http://121.40.93.230/test/api.php?api=Regist&userID=%@&passWd=%@&email=%@",user,password,email]

@interface VCRegister ()

@end

@implementation VCRegister

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=YES;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBK"]];
    _okButton.backgroundColor=[UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    _okButton.layer.cornerRadius=5;
    
    _cancelButton.backgroundColor=[UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    _cancelButton.layer.cornerRadius=5;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (IBAction)returnKeybord:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)okBtn:(id)sender {
    NSString* strUser=_userTX.text;
    NSString* strPassword=_passwordTX.text;
    NSString* strEmail=_emailTX.text;
    
    NSString* strUrl = RegisterURL(strUser, strPassword, strEmail);
    NetDownloadTS* net=[[NetDownloadTS alloc]init];
    [net downloadURL:strUrl with:1 complete:^(NSData* data,int tag){
        _data=data;
        [self parse:_data];
    }];
}


- (void)parse:(NSData*)data
{
    NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dic);
    
}



- (IBAction)cancelBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
