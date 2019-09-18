//
//  FNTeamPromoteController.m
//  SuperMode
//
//  Created by jimmy on 2017/10/18.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNTeamPromoteController.h"
#import "FDSlideBar.h"
#import "FNAPIHome.h"
#import "HotSearchHeadColumnModel.h"
#import "FNTeamPromoteView.h"
#import "FNTeamPromoteViewModel.h"
@interface FNTeamPromoteController ()
@property (nonatomic, strong)NSArray<HotSearchHeadColumnModel *>* ColumnArray;
@property (nonatomic, strong)FDSlideBar *slideBar;
@property (nonatomic, strong)FNTeamPromoteView* promoteview;
@property (nonatomic, strong)FNTeamPromoteViewModel* viewmodel;

@end

@implementation FNTeamPromoteController{
    NSMutableArray *title;
    NSString *ColumnSkipUIIdentifier;
}
- (void)setIsNotHome:(BOOL)isNotHome{
    [super setIsNotHome:isNotHome];
    if (self.isNotHome) {
        self.btmcons.constant = 0;
    }else{
        self.btmcons.constant = XYTabBarHeight;
    }
    [self.view layoutIfNeeded];
}
- (FNTeamPromoteView *)promoteview{
    if (_promoteview == nil) {
        _promoteview = [[FNTeamPromoteView alloc]initWithViewModel:self.viewmodel];
    }
    return _promoteview;
}
- (FNTeamPromoteViewModel *)viewmodel{
    if (_viewmodel == nil) {
        _viewmodel = [FNTeamPromoteViewModel new];
    }
    return _viewmodel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"家族推广订单";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    [FNAPIHome startWithRequests:@[[self apiRequestHotSearchHeadColumn]] withFinishedBlock:^(NSArray *erros) {
        _slideBar = [[FDSlideBar alloc] initWithFrame:CGRectMake(50, 0, FNDeviceWidth-50, 40)];
        _slideBar.backgroundColor = FNWhiteColor;
        _slideBar.is_middle=YES;
        _slideBar.itemsTitle = title;
        _slideBar.itemColor = FNGlobalTextGrayColor;
        _slideBar.itemSelectedColor = FNMainGobalTextColor;
        _slideBar.sliderColor = FNMainGobalTextColor;
        _slideBar.fontSize=13;
        _slideBar.SelectedfontSize=14;
        [self slideBarItemSelected];
        self.navigationItem.titleView = _slideBar;
        
        [self.view addSubview:self.promoteview];
        [self.promoteview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
        self.btmcons = [self.promoteview autoPinEdgeToSuperviewEdge:(ALEdgeBottom) withInset:self.isNotHome? 0:XYTabBarHeight];
    }];
}
-(void)slideBarItemSelected{
    [_slideBar slideBarItemSelectedCallback:^(NSUInteger index) {
        ColumnSkipUIIdentifier=self.ColumnArray[index].SkipUIIdentifier;
        [SVProgressHUD show];
        self.viewmodel.SkipUIIdentifier=ColumnSkipUIIdentifier;
        self.viewmodel.jm_page=1;
        [self.viewmodel.refreshDataCommand execute:nil];
    }];
}
//获取商品栏目（淘宝，京东，拼多多那几个大栏目）
- (FNAPIHome *)apiRequestHotSearchHeadColumn{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"type":@"4"}];
    return [FNAPIHome apiHomeForHotSearchHeadColumnWithParams:params success:^(id respondsObject) {
        self.ColumnArray=respondsObject;
        title=[[NSMutableArray alloc]init];
        [respondsObject enumerateObjectsUsingBlock:^(HotSearchHeadColumnModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [title addObject:obj.name];
            if ([obj.is_check integerValue]==1) {
                ColumnSkipUIIdentifier=obj.SkipUIIdentifier;
            }
        }];
        if (ColumnSkipUIIdentifier==nil) {
            ColumnSkipUIIdentifier=self.ColumnArray[0].SkipUIIdentifier;
        }
    } failure:^(NSString *error) {
        
    } isHidden:YES];
}

@end
