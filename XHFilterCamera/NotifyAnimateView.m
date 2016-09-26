//
//  NotifyAnimateView.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "NotifyAnimateView.h"
#import "common.h"

@interface NotifyAnimateView()

@property (nonatomic,strong)UILabel *label;
@property (nonatomic,assign)CGFloat labelWidth;
@property (nonatomic,assign)CGFloat labelHeight;

@end

@implementation NotifyAnimateView

static id instance;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)sharedNotifyAnimateView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.labelHeight = 30.0;
        self.labelWidth = kScreenWidth * 0.4;
        self.label = [[UILabel alloc]init];
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:self.label];
    }
    return self;
}

- (void)showNotify:(NSString *)string {
    self.label.text = string;
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textColor = [UIColor blackColor];
    self.label.alpha = 0.2;
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.frame = CGRectMake((kScreenWidth - self.labelWidth)/2, kScreenHeight/9, self.labelWidth, self.labelHeight);
    [self addAnimation];
}

- (void)addAnimation {
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        self.label.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            self.label.transform = CGAffineTransformMakeScale(0.8, 0.8);
            self.label.alpha = 0.0;
        } completion:nil];
        
    }];
    
    
}


@end
