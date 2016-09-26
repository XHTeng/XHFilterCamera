//
//  GPUImageCustomLookupFilter.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "GPUImageCustomLookupFilter.h"

@interface GPUImageCustomLookupFilter()

@property (nonatomic,strong)GPUImagePicture *lookupImageSource;

@end

@implementation GPUImageCustomLookupFilter

- (instancetype)initWithLookupImageName:(NSString *)lookupImageName {
    self = [super init];
    if (self) {
        UIImage *image = [UIImage imageNamed:lookupImageName];
        self.lookupImageSource = [[GPUImagePicture alloc]initWithImage:image];
        GPUImageLookupFilter *lookupFilter = [[GPUImageLookupFilter alloc]init];
        
        [self addTarget:lookupFilter];
        [self.lookupImageSource addTarget:lookupFilter atTextureLocation:1];
        [self.lookupImageSource processImage];
        self.initialFilters = @[lookupFilter];
        self.terminalFilter = lookupFilter;
    }
    return self;
}

@end
