//
//  FNNewStorePayAttributeCell.h
//  新版嗨如意
//
//  Created by Weller on 2019/7/31.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNNewStorePayAttributeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *lblTitle;
- (void)setIsSelected: (BOOL)isSelected;
- (void)setDisable;

@end

NS_ASSUME_NONNULL_END
