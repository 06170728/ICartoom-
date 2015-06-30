//
//  VCRegister.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCRegister : UIViewController
{
    __block NSData* _data;
}
@property (weak, nonatomic) IBOutlet UITextField *userTX;
@property (weak, nonatomic) IBOutlet UITextField *passwordTX;
@property (weak, nonatomic) IBOutlet UITextField *emailTX;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


- (IBAction)returnKeybord:(id)sender;

- (IBAction)okBtn:(id)sender;
- (IBAction)cancelBtn:(id)sender;



@end
