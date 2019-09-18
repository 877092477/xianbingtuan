//
//  FNBrokerageDetailHeadView.h
//  THB
//
//  Created by 李显 on 2018/9/11.
//  Copyright © 2018年 方诺科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNBrokerageDetailHeadView : UITableViewHeaderFooterView
/** headerTitle **/
@property (nonatomic, strong)UILabel *headTitle;

/** headImage **/
@property (nonatomic, strong)UIImageView * headImageView;



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@end
