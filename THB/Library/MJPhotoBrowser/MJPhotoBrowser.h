//
//  MJPhotoBrowser.h
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@class MJPhotoToolbar;
@protocol MJPhotoBrowserDelegate;

@interface MJPhotoBrowser : UIViewController <UIScrollViewDelegate>
// 代理
@property (nonatomic, weak) id<MJPhotoBrowserDelegate> delegate;
// 所有的图片对象(MJPhoto)
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;
// 工具条
@property (nonatomic, strong) MJPhotoToolbar *toolbar;
@property (nonatomic, strong) UIScrollView *photoScrollView;
@property (nonatomic, assign) BOOL isDismiss;
// 显示
- (void)show;
//隐藏
- (void)hiddenMethod;
//
- (void)respondSingleTap;
@end

@protocol MJPhotoBrowserDelegate <NSObject>
@optional
// 切换到某一页图片
- (void)photoBrowser:(MJPhotoBrowser *)photoBrowser didChangedToPageAtIndex:(NSUInteger)index;
@end
