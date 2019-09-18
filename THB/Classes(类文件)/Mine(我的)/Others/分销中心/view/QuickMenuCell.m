//
//  QuickMenuCell.m
//  THB
//
//  Created by zhongxueyu on 16/7/29.
//  Copyright © 2016年 方诺科技. All rights reserved.
//
/**
 
 * ============================================================================
 
 * 版权所有  ©2013-2016 方诺科技，并保留所有权利。
 
 * 网站地址: http://www.fnuo123.com；
 
 * ----------------------------------------------------------------------------
 
 * 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和
 
 * 使用；不允许对程序代码以任何形式任何目的的再发布。
 
 * ============================================================================
 
 */

#import "QuickMenuCell.h"
@implementation QuickMenuCell
@synthesize menuView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    menuView = [[FXQuickView alloc]initWithFrame:CGRectMake(0, 0, XYScreenWidth, 90)];
    menuView.delegate = self;
    [self addSubview:menuView];
}

-(void)OnTapMenuView:(NSInteger)index
{
    
    //    MenuModel *model =tapArray[tag];
    //    NSString *url =model.url;
    [self.delegate OnTapFXMenuView:index];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
