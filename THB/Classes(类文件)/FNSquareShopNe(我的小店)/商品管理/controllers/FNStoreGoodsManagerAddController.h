//
//  FNStoreGoodsManagerAddController.h
//  新版嗨如意
//
//  Created by Weller on 2019/8/10.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FNStoreManagerGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FNStoreGoodsManagerAddController : SuperViewController

@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, copy) NSString *cateId;
@property (nonatomic, copy) NSString *cateName;

@end

NS_ASSUME_NONNULL_END
