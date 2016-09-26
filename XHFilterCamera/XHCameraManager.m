//
//  XHCameraManager.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "XHCameraManager.h"

@implementation XHCameraManager

- (instancetype )initWithSessionPreset:(NSString *)sessionPreset cameraPosition:(AVCaptureDevicePosition)cameraPosition {
    
    if (self = [super initWithSessionPreset:sessionPreset cameraPosition:cameraPosition]) {
        // 加上判断
//        if ([self.captureSession canSetSessionPreset:AVCaptureSessionPreset640x480]) {
//            [self.captureSession setSessionPreset:AVCaptureSessionPreset640x480];
//        }

    }
    
    return self;
}

@end
