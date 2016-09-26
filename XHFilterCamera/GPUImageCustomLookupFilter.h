//
//  GPUImageCustomLookupFilter.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <GPUImage/GPUImage.h>

@interface GPUImageCustomLookupFilter : GPUImageFilterGroup
- (instancetype)initWithLookupImageName:(NSString *)lookupImageName;
@end
