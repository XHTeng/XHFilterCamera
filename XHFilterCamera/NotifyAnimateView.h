//
//  NotifyAnimateView.h
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NotifyAnimateView : NSObject
+ (instancetype)sharedNotifyAnimateView;
- (void)showNotify:(NSString *)string;
@end
