//
//  XHFilterViewController.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/25.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "XHFilterViewController.h"
#import "XHCameraManager.h"
#import "XHCameraMainView.h"
#import "XHCustomLookupFilter.h"
#import "XHFilterModel.h"
#import "XHGestureView.h"
#import "XHFilterCommon.h"
#import "XHFilterItem.h"

@interface XHFilterViewController()<XHCameraFilterDelegate,XHCameraMainViewDelegate,GestureViewControl>

@property (nonatomic,strong)XHCameraManager *cameraManager;
@property (nonatomic,strong)GPUImageView *gpuImageView;
@property (nonatomic,strong)XHCameraMainView *cameraView;
@property (nonatomic,assign)int currentFilterIndex;
@property (nonatomic,strong)XHCustomLookupFilter *lookupFilter;
@property (nonatomic,strong)XHFilterModel *filterModel;
// 存放拍完照的相片，用于左下角显示
@property (nonatomic,strong)NSArray *photoArray;
@property (nonatomic,strong)XHGestureView *gestureView;

// 剪裁滤镜
@property (nonatomic,strong)GPUImageCropFilter *cropFilter;
@end

@implementation XHFilterViewController

#pragma mark - lazy
- (XHCameraManager *)cameraManager {
    if (_cameraManager == nil) {
        // 设置默认开启的前后摄像头，调整照片质量，太高就会拍照卡顿
        _cameraManager = [[XHCameraManager alloc]initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
        _cameraManager.outputImageOrientation = UIInterfaceOrientationPortrait;
        
        // 设置默认原图
        [self.cameraManager addTarget:self.cropFilter];
    }
    return _cameraManager;
}

// 中间时时的相机滤镜
- (GPUImageView *)gpuImageView {
    if (_gpuImageView == nil) {
        _gpuImageView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.7)];
        _gpuImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    }
    return _gpuImageView;
}

// 整个界面
- (XHCameraMainView *)cameraView {
    if (_cameraView == nil) {
        _cameraView = [[XHCameraMainView alloc]initWithFrame:self.view.bounds];
    }
    return _cameraView;
}

- (XHFilterModel *)filterModel {
    if (_filterModel == nil) {
        _filterModel = [XHFilterModel sharedFilterModel];
    }
    return _filterModel;
}

- (XHGestureView *)gestureView {
    if (_gestureView == nil) {
        CGFloat height = kCameraBottomHeight;
        _gestureView = [[XHGestureView alloc]initWithFrame:CGRectMake(0, kTopViewHeight, kScreenWidth, kScreenHeight - kTopViewHeight - height - kCameraFilterHeight)];
    }
    return _gestureView;
}

// 剪裁滤镜
- (GPUImageCropFilter *)cropFilter {
    if (_cropFilter == nil) {
        _cropFilter = [[GPUImageCropFilter alloc]init];
        // 设置剪裁大小，从哪个比例点开始剪裁多大比例
        _cropFilter.cropRegion = CGRectMake(0,0.1,1,0.75);
        [_cropFilter addTarget:self.gpuImageView];
    }
    return _cropFilter;
}

#pragma load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    // 异步，不然卡线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.cameraManager startCameraCapture];
    });
    
    // 添加整个视图view
    [self.view addSubview:self.cameraView];
    // 添加滤镜相机视图
    [self.cameraView.preView addSubview:self.gpuImageView];
    // 设置代理
    self.cameraView.filterView.filterCollectionDelegate = self;
    self.cameraView.delegate = self;
    
    self.currentFilterIndex = 0;
    [self addGestureView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - cameraFilterDelegate
// 滑动切换滤镜
- (void)switchFilter:(int)index {
    // 清空之前的滤镜
    [self.cropFilter removeAllTargets];
    [self.lookupFilter removeAllTargets];
    [self.cameraManager removeAllTargets];
    self.currentFilterIndex = index;

    // 重新设置滤镜
    XHFilterItem *filterItem = self.filterModel.filterList[index];
    NSString *lookupImageName = filterItem.lookupImageName;
    
    self.lookupFilter = [[XHCustomLookupFilter alloc]initWithLookupImageName:lookupImageName];
    [self.cropFilter addTarget:self.lookupFilter];
    [self.cameraManager addTarget:self.cropFilter];
    [self.lookupFilter addTarget:self.gpuImageView];
}


#pragma mark - cameraMainView delegate

// 点击打开相册
- (void)browsePhoto:(NSArray *)array {
    NSLog(@"点击了打开相册");
    self.photoArray = array;
}

// 点击拍照
- (void)takePhoto {
    if (self.currentFilterIndex == 0) {
        [self capturePhotoWithFilter:self.cropFilter];
    }else {
        [self capturePhotoWithFilter:self.lookupFilter];
    }
}

- (void)capturePhotoWithFilter:(GPUImageOutput<GPUImageInput> *)filer {
    [self.cameraManager capturePhotoAsImageProcessedUpToFilter:filer withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        if (error != nil) {
            NSLog(@"takePhotoError:(%@)",error);
        } else {
            if (processedImage != nil) {
                [self takePhotoFinished:processedImage];
            }
        }
    }];
}

#pragma mark - 保存照片到相册，显示到照相机，
- (void)takePhotoFinished:(UIImage *)image {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"");
    });
    
    [self.cameraView addPreviewImageView];
    [self.cameraView addNumberLabel];
    [self.cameraView setImageForPreviewImageView:image];
}

// 保存成功的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@",contextInfo);
}

// 切换前后镜头，并回到当前滤镜
- (void)switchCamera {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 切换镜头
        [self.cameraManager rotateCamera];
        [self switchFilter:self.currentFilterIndex];
    });
}

// 点击关闭按钮
- (void)closeMainView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - gestureview delegate
// 左右滑动切换
- (void)leftSwipe {
    [self.cameraView.filterView filterCellScrollToLeft:YES];
}

- (void)rightSwipe {
    [self.cameraView.filterView filterCellScrollToLeft:NO];
}
// 添加手势
- (void)addGestureView {
    self.gestureView.gestureControl = self;
    [self.view addSubview:self.gestureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"收到了内存警告");
}

@end
