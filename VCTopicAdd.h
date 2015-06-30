//
//  VCTopicAdd.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"

@interface VCTopicAdd : UIViewController <UITextFieldDelegate,ASIHTTPRequestDelegate>
{
    UIScrollView* _SV;
}

//发送图片
@property (retain,nonatomic) UIButton* btnSend;
//滚动视图
@property (retain,nonatomic) UIScrollView* svImage;

@property (retain,nonatomic) UIImage* mMainImage;

@property (retain,nonatomic) UIButton* btnAddMore;

@end
