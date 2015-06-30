//
//  NetDownloadTS.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-15.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "NetDownloadTS.h"

@implementation NetDownloadTS
- (void)downloadURL:(NSString*)url with:(int)tag complete:(finishedBlock)finished
{
    _tag=tag;
    _finishBlock=finished;
    
    //不使用缓存
    //超过60秒断开连接
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    
    //设置http的连接方式
    //GET:参数显示在连接地址上
    //http://login.php?uname=michael&pass=123
    //POST::参数不显示在连接的地址上   可以获取数据,也可以上传数据
    
    //PUSH:与POST类似
    //DELETE:删除数据时使用,不太常用
    [request setHTTPMethod:@"POST"];
    _connect=[[NSURLConnection alloc]initWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _data=[[NSMutableData alloc]init];
}



-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_data!=nil) {
        _finishBlock(_data,_tag);
    }
}


@end
