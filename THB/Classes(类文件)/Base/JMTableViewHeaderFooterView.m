//
//  JMTableViewHeaderFooterView.m
//  SuperMode
//
//  Created by jimmy on 2017/6/8.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "JMTableViewHeaderFooterView.h"

@implementation JMTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self jm_setupViews];
    }
    return self;
}

- (void)jm_setupViews{}

@end
