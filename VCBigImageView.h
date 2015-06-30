//
//  VCBigImageView.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ASIHTTPRequest.h"

@interface VCBigImageView : UIViewController <ASIHTTPRequestDelegate>
{
    UIScrollView* _SV;
    UIImageView* _iView;
}
@property (retain,nonatomic)NSString* strUrl;
@end
