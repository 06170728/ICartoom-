//
//  VCLogin.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedCustonButton.h"

@interface VCLogin : UIViewController
{
    BOOL _isSavePassword;
}


@property (weak, nonatomic) IBOutlet UIImageView *iconLogin;
@property (weak, nonatomic) IBOutlet UITextField *userTX;
@property (weak, nonatomic) IBOutlet UITextField *passwordTX;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet SelectedCustonButton *savePasswordBtn;

- (IBAction)savePasswordAct:(id)sender;
- (IBAction)autoLoginAct:(id)sender;

- (IBAction)loginBtn:(id)sender;

- (IBAction)registerBtn:(id)sender;

- (IBAction)back:(id)sender;

- (IBAction)returnKeybord:(id)sender;




@end
