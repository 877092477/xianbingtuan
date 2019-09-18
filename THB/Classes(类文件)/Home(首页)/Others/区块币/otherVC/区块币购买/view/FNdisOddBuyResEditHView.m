//
//  FNdisOddBuyResEditHView.m
//  新版嗨如意
//
//  Created by Jimmy on 2019/5/8.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNdisOddBuyResEditHView.h"

@implementation FNdisOddBuyResEditHView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initializedSubviews];
        
    }
    return self;
}

- (void)initializedSubviews{
    
    self.titleLB=[[UILabel alloc]init];
    [self addSubview:self.titleLB];
    self.titleLB.font=[UIFont systemFontOfSize:15];
    self.titleLB.textColor=RGB(102, 102, 102);
    self.titleLB.textAlignment=NSTextAlignmentLeft;
    
    self.resultLB=[[UILabel alloc]init];
    [self addSubview:self.resultLB];
    self.resultLB.textColor=RGB(201, 201, 201);
    self.resultLB.font=[UIFont systemFontOfSize:15];
    self.resultLB.textAlignment=NSTextAlignmentLeft;
    
    self.titleLB.sd_layout
    .leftSpaceToView(self, 15).centerYEqualToView(self).widthIs(105).heightIs(20);
    
    self.resultLB.sd_layout
    .leftSpaceToView(self, 120).centerYEqualToView(self).rightSpaceToView(self, 15).heightIs(20);
    
    UIView *line=[UIView new];
    line.backgroundColor=RGB(240, 240, 240);
    [self addSubview:line];
    line.sd_layout
    .leftSpaceToView(self, 0).bottomSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(1);
    
}
@end
