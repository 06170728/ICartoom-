//
//  AppConst.h
//  ICartoom爱动漫
//
//  Created by qianfeng on 14-9-17.
//  Copyright (c) 2014年 Qianfeng. All rights reserved.
//

#ifndef ICartoom____AppConst_h
#define ICartoom____AppConst_h


#define BaiduMapKey TTwNupNcAhtyQoKuBf1fi3Aw


//上传数据地址
#define UpLoad_URL @"http://121.40.93.230/appPHP/uploadTopic.php?cateId=%d"

//下载数据地址
//sNum:开始数据的条目 0     40
//eNum:获得接受的条目 10    10
#define Get_URL @"http://121.40.93.230/appPHP/getTopic.php?sNum=%d&eNum=%d"


//获取数据中最新的数据
//number 获得数据元素个数 20
#define GetLatest_URL @"http://121.40.93.230/appPHP/getLatestTopics.php?number=%d"


#define GetTopicImageURL @"http://121.40.93.230/appPHP/%@"
#define GetTopicSmallImageURL @"http://121.40.93.230/appPHP/%@_small"

#endif
