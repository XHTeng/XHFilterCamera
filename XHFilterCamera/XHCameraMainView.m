//
//  XHCameraMainView.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "XHCameraMainView.h"
#import "XHFilterCommon.h"

@interface XHCameraMainView()

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIView *bottomView;

@property (nonatomic,strong)UIButton *albumButton;

@property (nonatomic,strong)UIImageView *previewImageView;
@property (nonatomic,assign)int photoNumber;
@property (nonatomic,strong)UILabel *numberLabel;
@property (nonatomic,strong)NSMutableArray *tmpPhotoArray;

@end

@implementation XHCameraMainView

#pragma mark - lazy

- (UIView *)preView {
    if (_preView == nil) {
        _preView = [[UIView alloc]initWithFrame:CGRectMake(0, kTopViewHeight, kScreenWidth, kPreViewHeight)];
    }
    return _preView;
}

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopViewHeight)];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

// 设置底部滚动的item
- (XHCameraFilterCollectionView *)filterView{
    if (_filterView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 设置底部滚动条的frame
        _filterView = [[XHCameraFilterCollectionView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kCameraBottomHeight - kCameraFilterHeight , kScreenWidth, kCameraFilterHeight) collectionViewLayout:layout];
    }
    return _filterView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - kCameraBottomHeight, kScreenWidth, kCameraBottomHeight)];
        _bottomView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomView;
}

// 拍照后的选取相册按钮
- (UIButton *)albumButton {
    if (_albumButton == nil) {
        _albumButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth/8, (kCameraBottomHeight - kButtonClickWidth)/2, kButtonClickWidth, kButtonClickWidth)];
        _albumButton.backgroundColor = [UIColor clearColor];
        [_albumButton setImage:[UIImage imageNamed:@"cameraAlbumNormal"] forState:UIControlStateNormal];
        [_albumButton setImage:[UIImage imageNamed:@"cameraAlbumPress"] forState:UIControlStateSelected];
        [_albumButton addTarget:self action:@selector(browsePhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _albumButton;
}


#pragma mark - load
- (instancetype )initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    self.backgroundColor = [UIColor whiteColor];
    // 顶部
    [self addSubview:self.topView];
    // 相机切换按钮
    [self addTopButtons];
    // 中间
    [self addSubview:self.preView];
    // 底部
    [self addSubview:self.bottomView];
    // 相册按钮
    [self.bottomView addSubview:self.albumButton];
    // 拍照按钮
    [self addTriggerButton];
    // 关闭按钮
    [self addCloseButton];
    // 底部滚动的item
    [self addSubview:self.filterView];
}

#pragma mark - public

- (void)addPreviewImageView {
    if (self.previewImageView == nil) {
        self.previewImageView = [[UIImageView alloc]initWithFrame:self.albumButton.frame];
        self.previewImageView.contentScaleFactor = [UIScreen mainScreen].scale;
        self.previewImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.previewImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.previewImageView.clipsToBounds = YES;
        self.previewImageView.userInteractionEnabled = YES;
        [self.bottomView addSubview:self.previewImageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toPhotoBrowse)];
        [self.previewImageView addGestureRecognizer:tap];
        self.photoNumber = 0;
    }
}

- (void)addNumberLabel {
    if (self.numberLabel == nil) {
        self.numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 28, 16)];
        self.numberLabel.center = CGPointMake(self.previewImageView.frame.origin.x + self.previewImageView.frame.size.width, self.previewImageView.frame.origin.y);
        self.numberLabel.backgroundColor = [UIColor colorWithRed:0.918 green:0.333 blue:0.329 alpha:1.0];
        self.numberLabel.layer.cornerRadius = 8;
        self.numberLabel.layer.masksToBounds = YES;
        self.numberLabel.textColor = [UIColor whiteColor];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:self.numberLabel];
    }
    self.photoNumber = self.photoNumber + 1;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",self.photoNumber];
}

- (void)setImageForPreviewImageView:(UIImage *)image {
    [self.tmpPhotoArray addObject:image];
    [self uploadPreviewImageView:image];
}

- (void)reloadPreviewImageView:(NSMutableArray *)photoArray {
    if (photoArray.count == 0) {
        self.previewImageView.hidden = YES;
        self.albumButton.hidden = NO;
        self.numberLabel.hidden = YES;
        self.photoNumber = 1;
    } else {
        UIImage *img = (UIImage *)photoArray[photoArray.count-1];
        [self uploadPreviewImageView:img];
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",photoArray.count];
        self.photoNumber = (int)photoArray.count + 1;
    }
}

- (void)uploadPreviewImageView:(UIImage *)image {
    self.previewImageView.hidden = NO;
    self.numberLabel.hidden = NO;
    self.previewImageView.image = image;
    CGPoint lastCenter = self.previewImageView.center;
    self.previewImageView.frame = CGRectMake(kScreenWidth/8, kCameraBottomHeight/2 , 0,0);
    self.previewImageView.center = lastCenter;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.6 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.previewImageView.frame = CGRectMake(kScreenWidth/8, (kCameraBottomHeight - kButtonClickWidth)/2 , kButtonClickWidth, kButtonClickWidth);
    } completion:nil];
    
}

// 相机切换按钮
- (void)addTopButtons {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - kButtonClickWidth, 0, kButtonClickWidth, kTopViewHeight)];
        [button setImage:[UIImage imageNamed:@"switchNormal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"switchPress"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(topButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:button];
}

- (void)toPhotoBrowse{
    NSLog(@"点击打开啊  相册");
}

// 拍照按钮
- (void)addTriggerButton {
    UIImage *triggerNormalImage = [UIImage imageNamed:@"cameraTriggerNormal"];
    UIButton *triggerButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - triggerNormalImage.size.width)/2, (kCameraBottomHeight - triggerNormalImage.size.height)/2, triggerNormalImage.size.width, triggerNormalImage.size.height)];
    triggerButton.backgroundColor = [UIColor clearColor];
    [triggerButton setImage:triggerNormalImage forState:UIControlStateNormal];
    [triggerButton setImage:[UIImage imageNamed:@"cameraTriggerPress"] forState:UIControlStateSelected];
    [triggerButton addTarget:self action:@selector(triggerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:triggerButton];
}

// 关闭按钮
- (void)addCloseButton {
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth*7/8 - kButtonClickWidth, (kCameraBottomHeight - kButtonClickWidth)/2, kButtonClickWidth, kButtonClickWidth)];
    closeButton.backgroundColor = [UIColor clearColor];
    [closeButton setImage:[UIImage imageNamed:@"cameraCloseNormal"] forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"cameraClosePress"] forState:UIControlStateSelected];
    [closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottomView addSubview:closeButton];
}

- (void)topButtonPressed {
    if ([self.delegate respondsToSelector:@selector(switchCamera)]) {
        [self.delegate switchCamera];
    }
}

- (void)browsePhoto {
    if ([self.delegate respondsToSelector:@selector(browsePhoto:)]) {
        [self.delegate browsePhoto:self.tmpPhotoArray];
    }
}

- (void)triggerButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(takePhoto)]) {
        [self.delegate takePhoto];
    }
}

- (void)closeButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(closeMainView)]) {
        [self.delegate closeMainView];
    }
}

- (void)topButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(switchCamera)]) {
        [self.delegate switchCamera];
    }
}


@end
