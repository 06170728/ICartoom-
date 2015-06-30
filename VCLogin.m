
//
//  VCLogin.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "VCLogin.h"
#import "VCRegister.h"
#import "NetDownloadTS.h"

#define LoginURL(user,password) [NSString stringWithFormat:@"http://121.40.93.230/appPHP/login.php?userName=%@&password=%@",user,password]
@interface VCLogin ()

@end

@implementation VCLogin

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.tabBar.hidden=NO;
}



-(void)viewWillAppear:(BOOL)animated
{
      self.navigationController.navigationBarHidden=YES;
      self.tabBarController.tabBar.hidden=YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _iconLogin.layer.cornerRadius=50;
    _iconLogin.clipsToBounds=YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBK"]];
    
    _loginButton.backgroundColor=[UIColor colorWithRed:0 green:0.6 blue:1 alpha:1];
    _loginButton.layer.cornerRadius=5;
    
    
    //保存密码勾选框
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* strSavePasswordState=[user objectForKey:@"save_password"];
    if ([strSavePasswordState isEqualToString:@"1"]) {
        _savePasswordBtn.isOn = YES;
    }
    else
    {
        _savePasswordBtn.isOn = NO;
    }
    
    
    
    //保存密码输入
    NSString* strPassword=[user objectForKey:@"password"];
    if (strPassword!=nil) {
          _passwordTX.text=strPassword;
    }
    
    //保存账户
    NSString* strUser=[user objectForKey:@"user"];
    if (strUser!=nil) {
        _userTX.text=strUser;
    }
  
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


//保存登录密码
- (IBAction)savePasswordAct:(id)sender {
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    
    if (_isSavePassword == NO) {
        [user setObject:@"1" forKey:@"save_password"];
        [user setObject:_passwordTX.text forKey:@"password"];
        [user setObject:_userTX.text forKey:@"user"];
        _isSavePassword = YES;
    }
    
    else
    {
        [user setObject:@"0" forKey:@"save_password"];
        [user setObject:nil forKey:@"password"];
        _isSavePassword = NO;
    }
    
    [user synchronize];
}



- (IBAction)autoLoginAct:(id)sender {
  
}


- (IBAction)loginBtn:(id)sender {
    NSString* strUser=_userTX.text;
    NSString* strPassword=_passwordTX.text;
    if (strUser == nil | strPassword == nil) {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入账户密码" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        
        
        
    }
}


- (IBAction)registerBtn:(id)sender {
    
//    CATransition* trans=[CATransition animation];
//    trans.type=kCATransitionMoveIn;
//    trans.duration=3;
//    trans.subtype=kCATransitionFromTop;
    
//      NSLog(@"nav.view==%@",self.navigationController.view);//UILayoutContainerView
//    [self.navigationController.view.layer addAnimation:trans forKey:nil];
    
    
//      NSLog(@"self.view==%@",self.view);                    //UIView
//    [self.view.layer addAnimation:trans forKey:nil];
    
  
    
    VCRegister* registerView=[[VCRegister alloc]init];
    registerView.title=@"注册账户";
    [self.navigationController pushViewController:registerView animated:YES];
}


- (IBAction)back:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)returnKeybord:(id)sender {
    [self.view endEditing:YES];
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
