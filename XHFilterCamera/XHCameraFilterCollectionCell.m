//
//  XHCameraFilterCollectionCell.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "XHCameraFilterCollectionCell.h"
#import "common.h"

@interface XHCameraFilterCollectionCell()

@end

@implementation XHCameraFilterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加item 图片
//        UIImage *filterImage = [UIImage imageNamed:@""];
//        self.filterImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kFilterCellWidth, kFilterCellImageHeight)];
//        self.filterImageView.image = filterImage;
//        [self addSubview:self.filterImageView];
        
        UILabel *filterLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        [self addSubview:filterLabel];
        
        filterLabel.font = [UIFont systemFontOfSize:14];
        filterLabel.textColor = [UIColor whiteColor];
        filterLabel.textAlignment = NSTextAlignmentCenter;
        filterLabel.layer.shadowRadius = 2;
        filterLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        filterLabel.layer.shadowOffset = CGSizeMake(0, 3);
        filterLabel.layer.shadowOpacity = 0.9;
        self.filterLabel = filterLabel;
    }
    return self;
}

@end
