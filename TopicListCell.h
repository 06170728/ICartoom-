//
//  TopicListCell.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-16.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicListCellModel.h"
@interface TopicListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UILabel *mAuthor;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *mComment;


@property (retain,nonatomic)UIImageView* mImageView;

@property (retain,nonatomic)TopicListCellModel* model;
@end
