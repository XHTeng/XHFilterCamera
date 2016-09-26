//
//  GestureView.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GestureView;
@protocol GestureViewControl <NSObject>

- (void)leftSwipe;
- (void)rightSwipe;

@end

@interface GestureView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,weak)id<GestureViewControl> gestureControl;
@end
