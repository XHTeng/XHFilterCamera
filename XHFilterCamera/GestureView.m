//
//  GestureView.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "GestureView.h"

@implementation GestureView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addGestures];
    }
    return self;
}

- (void)leftSwipe:(UISwipeGestureRecognizer *)swipe {
    if ([self.gestureControl respondsToSelector:@selector(leftSwipe)]) {
        [self.gestureControl leftSwipe];
    }
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)swipe {
    if ([self.gestureControl respondsToSelector:@selector(rightSwipe)]) {
        [self.gestureControl rightSwipe];
    }
}

- (void)addGestures {
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    
    
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:leftSwipe];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:rightSwipe];
}

@end
