//
//  XHGestureView.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHGestureView;
@protocol GestureViewControl <NSObject>

- (void)leftSwipe;
- (void)rightSwipe;

@end

@interface XHGestureView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic,weak)id<GestureViewControl> gestureControl;
@end
