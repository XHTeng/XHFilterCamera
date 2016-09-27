//
//  XHCameraFilterCollectionView.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/24.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "XHCameraFilterCollectionView.h"
#import "XHCameraFilterCollectionCell.h"
#import "XHFilterModel.h"
#import "XHFilterItem.h"
#import "XHNotifyAnimateView.h"

@interface XHCameraFilterCollectionView()

@property (nonatomic,strong)XHFilterModel *filterModel;
@property (nonatomic,strong)NSMutableArray *picNameArray;
@property (nonatomic,strong)NSIndexPath *currentIndexPath;

@end

@implementation XHCameraFilterCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self config];
    }
    return self;
}


#pragma mark - datasource

- (NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.picNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"filterCollectionCell";
    [collectionView registerClass:[XHCameraFilterCollectionCell class] forCellWithReuseIdentifier:identifier];
    XHCameraFilterCollectionCell *cell = (XHCameraFilterCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[XHCameraFilterCollectionCell alloc]init];
    }
    
    while ([cell.contentView.subviews lastObject] != nil) {
        UIView *tmpView = [cell.contentView.subviews lastObject];
        [tmpView removeFromSuperview];
    }
    NSString *imgName = (NSString *)self.picNameArray[indexPath.row];
    
    // 设置item图片，不能去掉，因为要取出名字显示顶部
    cell.filterImageView.image = [UIImage imageNamed:imgName];
    XHFilterItem *filterItem = (XHFilterItem *)self.filterModel.filterList[indexPath.row];
    cell.filterLabel.text = filterItem.title;
    cell.layer.borderWidth = 0;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    [self changeSelectedStates];
    NSArray *visiblePathArray = [self indexPathsForVisibleItems];
    visiblePathArray = [visiblePathArray sortedArrayUsingSelector:@selector(compare:)];
    
    NSIndexPath *needScrollToCenterIndexPath = [[NSIndexPath alloc]init];
    
    if (indexPath.row == [[visiblePathArray firstObject] row]) {
        needScrollToCenterIndexPath = visiblePathArray[visiblePathArray.count - 2];
        [self scrollToItemAtIndexPath:needScrollToCenterIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
        
    } else if (indexPath.row == [[visiblePathArray lastObject] row]) {
        needScrollToCenterIndexPath = visiblePathArray[1];
        [self scrollToItemAtIndexPath:needScrollToCenterIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    XHNotifyAnimateView *notifyAnimate = [XHNotifyAnimateView sharedNotifyAnimateView];
    XHFilterItem *filterItem = (XHFilterItem *)self.filterModel.filterList[indexPath.row];
    [notifyAnimate showNotify:filterItem.title];
    if ([self.filterCollectionDelegate respondsToSelector:@selector(switchFilter:)]) {
        [self.filterCollectionDelegate switchFilter:(int)indexPath.row];
    }
}

- (void)changeSelectedStates {
    for (XHCameraFilterCollectionCell *cell in self.visibleCells) {
        cell.layer.borderWidth = 0;
    }
    XHCameraFilterCollectionCell *currentCell = (XHCameraFilterCollectionCell *)[self cellForItemAtIndexPath:self.currentIndexPath];
    currentCell.layer.borderWidth = 1;
    currentCell.layer.borderColor = [UIColor orangeColor].CGColor;
}


- (void)config {
    self.filterModel = [XHFilterModel sharedFilterModel];
    self.picNameArray = [NSMutableArray arrayWithCapacity:self.filterModel.filterList.count];
    for (int index = 0; index < self.filterModel.filterList.count; index++) {
        XHFilterItem * filterItem = (XHFilterItem *)self.filterModel.filterList[index];
        [self.picNameArray addObject:filterItem.imageTilte];
    }
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - public

- (void)didSelectCollectionCell:(int)index {

    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self performSelector:@selector(changeSelectedStates) withObject:nil afterDelay:0.3];
}

- (void)filterCellScrollToLeft:(BOOL)isFromRightToLeft {
    if (self.currentIndexPath == nil) {
        self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    NSInteger row = 0;
    if (isFromRightToLeft) {
        row = self.currentIndexPath.row + 1;
    } else {
        row = self.currentIndexPath.row - 1;
    }
    row = row < 0 ? 0 : row;
    row = row > self.picNameArray.count - 1 ? self.picNameArray.count - 1 : row;
    self.currentIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self collectionView:self didSelectItemAtIndexPath:self.currentIndexPath];
}



@end
