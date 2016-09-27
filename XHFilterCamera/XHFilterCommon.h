//
//  XHFilterCommon.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#ifndef common_h
#define common_h

//camera filter name
#define kFilterNone @"原图"
#define kFilterZiRan @"自然"
#define kFilterTianMi @"甜美"
#define kFilterWeiMei @"唯美"
#define kFilterDianYa @"典雅"
#define kFilterFenNen @"粉嫩"
#define kFilterLuoKeKe @"洛可可"
#define kFilterABaoSe @"阿宝色"
#define kFilterQingLiang @"清凉"
#define kFilterFuGu @"复古"
#define kFilterHuaiJiu @"怀旧"
#define kFilterHeiBai @"黑白"
#define kFilterRouGuang @"柔光"

#define kFilterCustom1 @"自定义1"
#define kFilterCustom2 @"自定义2"
#define kFilterCustom3 @"自定义3"
#define kFilterCustom4 @"自定义4"
#define kFilterCustom5 @"自定义5"

#define kFilterStartTag 10000

typedef enum {
    ZiRan,
    TianMi,
    WeiMei,
    DianYa,
    FenNen,
    LuoKeKe,
    ABaoSe,
    QingLiang,
    FuGu,
    HuaiJiu,
    HeiBai,
    RouGuang,
    
    Custom1,
    Custom2,
    Custom3,
    Custom4,
    Custom5,
    None = 10000,
} Filter;

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

#define kTopViewHeight [UIScreen mainScreen].bounds.size.height * 0.1
#define kPreViewHeight [UIScreen mainScreen].bounds.size.height * 0.7
#define kBottomViewHeight [UIScreen mainScreen].bounds.size.height * 0.2

//camera view
#define kWidthRatio kScreenWidth/320
// 底部滚动的item高
#define kCameraFilterHeight [UIScreen mainScreen].bounds.size.height * 0.1
#define kCameraBottomHeight [UIScreen mainScreen].bounds.size.height * 0.2
#define kCameraBottom4SHeight 70
#define kFilterCellWidth 60
#define kFilterCellImageHeight [UIScreen mainScreen].bounds.size.height * 0.1
#define kFilterCellLabelHeight 40
#define kCameraViewTopButtonStartTag 11000

//beauty main view
#define kBeautyMainBottomHeight 50
#define kBeautyMainBottomButtonStartTag 11020

#define kIphone4sHeight 480
#define kIphone4sWidth 320
//#define kNavigationHeight 44
#define kButtonClickWidth 40

#endif /* common_h */
