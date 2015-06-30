//
//  TopicListCell.m
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import "TopicListCell.h"

@implementation TopicListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"init");
     
    }
    return self;
}

- (void)awakeFromNib
{
    _mImageView=[[UIImageView alloc]init];
    [self addSubview:_mImageView];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



-(void)setModel:(TopicListCellModel *)model
{
    _model=model;
    
    _mAuthor.text=model.mAuthor;
    _mTitle.text=model.mTitle;
    _postDate.text=model.mPostDate;
    _mImageView.frame=CGRectMake(0, 60, [model getImageHeght].width, [model getImageHeght].height);
    _mImageView.image=model.mImage;
    
    _mComment.center=CGPointMake(160, [model getCellHeight]-25);
}

@end
