//
//  XHCameraFilterCollectionView.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XHCameraFilterCollectionView;
@protocol XHCameraFilterDelegate <NSObject>

- (void)switchFilter:(int)index;

@end

@interface XHCameraFilterCollectionView : UICollectionView<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic,weak)id<XHCameraFilterDelegate> filterCollectionDelegate;
- (void)didSelectCollectionCell:(int)index;
- (void)filterCellScrollToLeft:(BOOL)isFromRightToLeft;
@end
