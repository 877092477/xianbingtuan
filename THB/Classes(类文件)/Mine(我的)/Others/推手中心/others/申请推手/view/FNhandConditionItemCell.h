//
//  FNhandConditionItemCell.h
//  新版嗨如意
//
//  Created by Jimmy on 2019/8/13.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNhandConditionsView.h"
#import "FNHandSlapdModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNhandConditionItemCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView   *bgImgView;
@property (nonatomic, strong)UIImageView   *stateImgView;
@property (nonatomic, strong)UILabel *titleLB; 
@end

NS_ASSUME_NONNULL_END
