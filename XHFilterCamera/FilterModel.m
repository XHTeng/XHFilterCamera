//
//  FilterModel.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "FilterModel.h"
#import "FilterItem.h"
#import "common.h"

@interface FilterModel()



@end

@implementation FilterModel


- (NSMutableArray *)filterList {
    if (_filterList == nil) {
        _filterList = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _filterList;
}

static id instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedFilterModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initFilterList];
    }
    return self;
}

- (void)initFilterList {
    NSArray *filterTitleArray = @[
                                  kFilterNone,
                                  kFilterZiRan,
                                  kFilterTianMi,
                                  kFilterQingLiang,
                                  kFilterFenNen,
                                  kFilterFuGu,
                                  kFilterRouGuang,
                                  kFilterWeiMei,
                                  kFilterHeiBai,
                                  kFilterABaoSe,
                                  kFilterHuaiJiu,
                                  kFilterDianYa,
                                  kFilterLuoKeKe,
                                  
                                  kFilterCustom1,
                                  kFilterCustom2,
                                  kFilterCustom3,
                                  kFilterCustom4,
                                  kFilterCustom5
                                  ];
    NSArray *lookupNameArray = @[
                                 @"lookupOriginal", @"lookupZiran", @"lookupTianmei", @"lookupQingliang", @"lookupFennen", @"lookupFugu", @"lookupRouguang", @"lookupWeimei", @"lookupHeibai", @"lookupAbaose", @"lookupHuaijiu", @"lookupDianya", @"lookupKeke",@"lookupCustom1",@"lookupCustom2",@"lookupCustom3",@"lookupCustom4",@"lookupCustom5"];
    
    // 无用了，但去除会报警告，找不到图片
    NSString *imageStr = @"filter0";
    for (int i = 0; i < filterTitleArray.count; i++) {
        FilterItem *item = [[FilterItem alloc]initWithCategory:kFilterStartTag + i title:filterTitleArray[i] imageTitle:imageStr lookupImageName:lookupNameArray[i]];
        [self.filterList addObject:item];
    }
}

@end
