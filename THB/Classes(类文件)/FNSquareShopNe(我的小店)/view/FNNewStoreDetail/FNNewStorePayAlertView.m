//
//  FNNewStorePayAlertView.m
//  新版嗨如意
//
//  Created by Weller on 2019/7/30.
//  Copyright © 2019年 方诺科技. All rights reserved.
//

#import "FNNewStorePayAlertView.h"
#import "FNNewStorePayAlertCell.h"

@interface FNNewStorePayAlertView() <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *btnBg;
@property (nonatomic, strong) UIView *vAlert;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UIButton *btnClose;

@property (nonatomic, strong) UILabel *lblPrice;
@property (nonatomic, strong) UILabel *lblCommission;
@property (nonatomic, strong) UITableView *tbvData;

@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) FNStorePayConfirmModel *model;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *type;
@end

@implementation FNNewStorePayAlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _type = @"请选择付款方式";
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _btnBg = [[UIButton alloc] init];;
    _vAlert = [[UIView alloc] init];;
    _lblTitle = [[UILabel alloc] init];;
    _btnClose = [[UIButton alloc] init];;
    _lblPrice = [[UILabel alloc] init];
    _lblCommission = [[UILabel alloc] init];
    _tbvData = [[UITableView alloc] init];;
    _btnConfirm = [[UIButton alloc] init];
    
    [self addSubview:_btnBg];
    [self addSubview:_vAlert];
    [_vAlert addSubview:_lblTitle];
    [_vAlert addSubview:_btnClose];
    
    [_vAlert addSubview:_lblPrice];
    [_vAlert addSubview:_lblCommission];
    [_vAlert addSubview:_tbvData];
    [_vAlert addSubview:_btnConfirm];
    
    [_btnBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@20);
        make.height.mas_equalTo(0);
    }];
    [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@18);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lblTitle);
        make.right.equalTo(@-10);
        make.width.height.mas_equalTo(24);
    }];
    [_lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.top.equalTo(@70);
        make.centerX.equalTo(@0);
    }];
    [_lblCommission mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.greaterThanOrEqualTo(@12);
        make.right.lessThanOrEqualTo(@-12);
        make.top.equalTo(self.lblPrice.mas_bottom).offset(12);
        make.centerX.equalTo(@0);
    }];
    [_tbvData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.lblCommission.mas_bottom).offset(10);
        make.bottom.equalTo(self.btnConfirm.mas_top).offset(-10);
    }];
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.height.mas_equalTo(44);
        make.bottom.equalTo(isIphoneX ? @-74 : @-40);
    }];
    
    _btnBg.backgroundColor = RGBA(0, 0, 0, 0.2);
    
    _vAlert.layer.backgroundColor = UIColor.whiteColor.CGColor;
    _vAlert.layer.cornerRadius = 13;
    
    _lblTitle.text = @"确认付款";
    _lblTitle.font = [UIFont boldSystemFontOfSize:15];
    
    [_btnClose setImage:IMAGE(@"store_coupone_close_button") forState: UIControlStateNormal];
    
    _lblPrice.textColor = RGB(51, 51, 51);
    _lblPrice.font = [UIFont boldSystemFontOfSize:24];
    
    _lblCommission.textColor = RGB(244, 47, 25);
    _lblCommission.font = kFONT12;
    
    _tbvData.delegate = self;
    _tbvData.dataSource = self;
    _tbvData.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tbvData.showsVerticalScrollIndicator = NO;
    _tbvData.bounces = NO;
    [_tbvData registerClass:[FNNewStorePayAlertCell class] forCellReuseIdentifier:@"FNNewStorePayAlertCell"];
    
    
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_btnBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnConfirm setImage: IMAGE(@"store_pay_alert_confirm") forState: UIControlStateNormal];
    [_btnConfirm addTarget:self action:@selector(onConfirmClick) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FNNewStorePayAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNNewStorePayAlertCell"];
    cell.vLine.hidden = indexPath.row == 0;
    
    
    if (indexPath.row == 0) {
        cell.lblTitle.text = @"订单金额";
        cell.lblTitle.textColor = RGB(153, 153, 153);
        
        cell.lblDesc.text = self.model.money;
        cell.lblDesc.textColor = RGB(51, 51, 51);
        cell.imgRight.hidden = YES;
    } else if (indexPath.row == 1) {
        cell.lblTitle.text = @"红包";
        cell.lblTitle.textColor = RGB(255, 84, 65);
        
        cell.lblDesc.text = self.model.red_packet_str;
        cell.lblDesc.textColor = RGB(51, 51, 51);
        cell.imgRight.hidden = YES;
    } else if (indexPath.row == 2) {
        cell.lblTitle.text = @"优惠券";
        cell.lblTitle.textColor = RGB(255, 84, 65);
        
        cell.lblDesc.text = self.model.yhq_str;
        cell.lblDesc.textColor = RGB(51, 51, 51);
        cell.imgRight.hidden = YES;
    } else if (indexPath.row == 3) {
        cell.lblTitle.text = @"满减优惠";
        cell.lblTitle.textColor = RGB(255, 84, 65);
        
        cell.lblDesc.text = self.model.full_reduction;
        cell.lblDesc.textColor = RGB(255, 84, 65);
        cell.imgRight.hidden = YES;
    } else if (indexPath.row == 4) {
        cell.lblTitle.text = @"商家信息";
        cell.lblTitle.textColor = RGB(153, 153, 153);
        
        cell.lblDesc.text = _title;
        cell.lblDesc.textColor = RGB(51, 51, 51);
        cell.imgRight.hidden = YES;
    } else if (indexPath.row == 5) {
        cell.lblTitle.text = @"付款方式";
        cell.lblTitle.textColor = RGB(255, 84, 65);
        
        cell.lblDesc.text = _type;
        cell.lblDesc.textColor = RGB(153, 153, 153);
        cell.imgRight.hidden = NO;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        if ([_delegate respondsToSelector:@selector(onAlertPayRedpackClick)]) {
            [_delegate onAlertPayRedpackClick];
        }
    } else if (indexPath.row == 2) {
        if ([_delegate respondsToSelector:@selector(onAlertPayCouponeClick)]) {
            [_delegate onAlertPayCouponeClick];
        }
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        if ([_delegate respondsToSelector:@selector(onAlertPayTypeClick)]) {
            [_delegate onAlertPayTypeClick];
        }
    }
    
}

- (void)setPay: (FNStorePayConfirmModel*) model {
    _model = model;
    
    self.lblPrice.text = [NSString stringWithFormat: @"￥%@", model.money];
    self.lblCommission.text = model.commission_str;
    
    [self.tbvData reloadData];
}

- (void)show: (NSString*)title {
    [self layoutIfNeeded];
    self.hidden = NO;
    
    _title = title;
    [_vAlert mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(556);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)dismiss {
    
    [_vAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
    }];
}

- (void)onConfirmClick {
    if ([_delegate respondsToSelector:@selector(onAlertPayClick)]) {
        [_delegate onAlertPayClick];
    }
}

- (void)setPayType: (NSString*)payType {
    _type = payType;
    [self.tbvData reloadData];
}

@end
