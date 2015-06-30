//
//  NetDownloadTS.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^finishedBlock)(NSData*,int tag);

@interface NetDownloadTS : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
{
    finishedBlock _finishBlock;
    NSURLConnection* _connect;
    int _tag;
    NSMutableData* _data;
}

- (void)downloadURL:(NSString*)url with:(int)tag complete:(finishedBlock)finished;

@end
