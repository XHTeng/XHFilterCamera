//
//  FilterItem.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "FilterItem.h"

@interface FilterItem()


@end

@implementation FilterItem
- (instancetype)initWithCategory:(int)category title:(NSString *)title imageTitle:(NSString *)imageTitle lookupImageName:(NSString *)lookupImageName {
    self = [super init];
    if (self) {
        self.category = category;
        self.title = title;
        self.imageTilte = imageTitle;
        self.lookupImageName = lookupImageName;
    }
    return self;
}
@end
