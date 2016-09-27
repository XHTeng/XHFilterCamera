//
//  XHFilterModel.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHFilterModel : NSObject
+ (instancetype)sharedFilterModel;
@property (nonatomic,strong)NSMutableArray *filterList;
@end