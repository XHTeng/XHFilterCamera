//
//  FilterItem.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterItem : NSObject
@property (nonatomic,assign)int category;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *lookupImageName;
@property (nonatomic,copy)NSString *imageTilte;
- (instancetype)initWithCategory:(int)category title:(NSString *)title imageTitle:(NSString *)imageTitle lookupImageName:(NSString *)lookupImageName;
@end
