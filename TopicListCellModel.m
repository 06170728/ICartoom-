//
//  TopicListCellModel.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "TopicListCellModel.h"

@implementation TopicListCellModel
- (CGFloat)getCellHeight
{
    CGFloat height = 0;
    height+=40;
    height+=20;
    height+=[self getImageHeght].height;
    height+=20;
    height+=40;
    height+=10;
    return height;
}



-(CGSize)getImageHeght
{
    CGSize imgSize;
    CGSize originSize=_mImage.size;
    
    if (originSize.width>320) {
        float widthRatio=originSize.width/320;
        imgSize.width=originSize.width/widthRatio;
        imgSize.height=originSize.height/widthRatio;
    }
    else
    {
        imgSize=_mImage.size;
    }
    
    return imgSize;
}
@end
