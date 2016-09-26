//
//  XHCameraMainView.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHCameraFilterCollectionView.h"

@class XHCameraMainView;
@protocol XHCameraMainViewDelegate <NSObject>

- (void)takePhoto;
- (void)browsePhoto:(NSArray *)array;
- (void)closeMainView;
- (void)switchCamera;

@end

@interface XHCameraMainView : UIView
@property (nonatomic,weak) id<XHCameraMainViewDelegate> delegate;
@property (nonatomic,strong)UIView *preView;
@property (nonatomic,strong)XHCameraFilterCollectionView *filterView;
- (void)addPreviewImageView;
- (void)addNumberLabel;
- (void)setImageForPreviewImageView:(UIImage *)image;
- (void)reloadPreviewImageView:(NSMutableArray *)photoArray;
- (void)uploadPreviewImageView:(UIImage *)image;
@end
