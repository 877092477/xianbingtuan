//
//  JMInviteRecordView.h
//  THB
//
//  Created by jimmy on 2017/4/7.
//  Copyright © 2017年 方诺科技. All rights reserved.
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

#import <UIKit/UIKit.h>
@class JMInviteFriendModel;
@interface JMInviteRecordView : UIView
@property (nonatomic, assign)CGFloat viewHeight;
@property (nonatomic, strong)JMInviteFriendModel* model;
@end
