//
//  SelectedCustonButton.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedCustonButton : UIControl
{
    UIImage* _selectedIMG;
    UIImage* _noselectedIMG;
    UIImageView* _iView;
    
    id _target;
    SEL _selector;
    
}

@property (assign,nonatomic) BOOL isOn;
@end
