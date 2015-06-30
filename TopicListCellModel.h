//
//  TopicListCellModel.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicListCellModel : NSObject

- (CGFloat)getCellHeight;
- (CGSize)getImageHeght;

@property (retain,nonatomic) NSString* mTitle;

@property (retain,nonatomic) NSString* mText;

@property (retain,nonatomic) NSString* mAuthor;

@property (retain,nonatomic) NSString* mPostDate;

@property (retain,nonatomic) NSString* strBigImage;

//大图
@property (retain,nonatomic) UIImage* mImage;

//小图
@property (retain,nonatomic) UIImage* mImageSmall;

@property (assign,nonatomic) NSUInteger mTag;
@end
