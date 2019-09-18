//
//  FNConnectionsRemoveMembersController.m
//  THB
//
//  Created by Weller Zhao on 2019/3/5.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNConnectionsRemoveMembersController.h"
#import "FNConnectionsChatController.h"
#import "FNCustomeNavigationBar.h"
#import "FNConnectionsHomeHeaderView.h"
#import "FNConnectionsHomeCell.h"
#import "FNConnectionsHomeHeaderCell.h"
#import "FNConnectionsSearchView.h"

#import "FNConnectionsHomeModel.h"
#import "FNConnectionsMemberModel.h"
#import "FNIndexSelectorView.h"

@interface FNConnectionsRemoveMembersController ()<UITableViewDelegate, UITableViewDataSource, FNConnectionsSearchViewDelegate>

@property (nonatomic, strong)FNCustomeNavigationBar* navigationView;
@property (nonatomic, strong) FNConnectionsSearchView *searchView;

@property (nonatomic, strong)UIButton* confirmBtn;
@property (nonatomic, strong)UIButton* backBtn;
@property (nonatomic, strong)UIButton* titleBtn;
@property (nonatomic, strong)UIImageView *imgHeader;

@property (nonatomic, strong) NSMutableArray<FNConnectionsMemberModel*> *members;

@property (nonatomic, strong) NSMutableArray<FNConnectionsMemberModel*> *selectedMembers;
// 记录已经选中的id
@property (nonatomic, strong) NSMutableSet<NSString*>* selectedIds;

@property (nonatomic, copy) NSString *keyword;

@end

@implementation FNConnectionsRemoveMembersController


- (FNConnectionsSearchView*)searchView {
    if (_searchView == nil) {
        _searchView = [[FNConnectionsSearchView alloc] init];
    }
    return _searchView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.members = [[NSMutableArray alloc] init];
    self.selectedMembers = [[NSMutableArray alloc] init];
    self.selectedIds = [[NSMutableSet alloc] init];
    self.keyword = @"";
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:(UIStatusBarStyleLightContent) animated:YES];
}


- (FNCustomeNavigationBar *)navigationView{
    if (_navigationView == nil) {
        _navigationView = [FNCustomeNavigationBar customeNavigationBarWithTitle:@""];
        
        self.confirmBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self.confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.confirmBtn.size = CGSizeMake(150, 40);
        
        _navigationView.rightButton = self.confirmBtn;
        _navigationView.backgroundColor = RED;
        
        UIView* leftView = [UIView new];
        self.backBtn = [[UIButton alloc] init];
        [self.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        self.backBtn.size = CGSizeMake(6, 12);
        [self.backBtn setImage:IMAGE(@"connection_button_back") forState:UIControlStateNormal];
        [leftView addSubview:self.backBtn];
        
        self.titleBtn = [[UIButton alloc] init];
        [self.titleBtn addTarget:self action:@selector(backBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self.titleBtn setTitle:@"移除成员" forState:UIControlStateNormal];
        self.titleBtn.size = CGSizeMake(XYScreenWidth - 120, 20);
        self.titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftView addSubview:self.titleBtn];
        leftView.frame = CGRectMake(0, 0, self.backBtn.width+self.titleBtn.width+15, 20);
        
        [self.backBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.backBtn autoSetDimensionsToSize:self.backBtn.size];
        [self.backBtn autoPinEdgeToSuperviewEdge:(ALEdgeLeft) withInset:0];
        
        [self.titleBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
        [self.titleBtn autoSetDimensionsToSize:self.titleBtn.size];
        [self.titleBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:0];
        
        _navigationView.leftButton = leftView;
        
    }
    return _navigationView;
}

- (void)jm_setupViews{
    
    self.view.backgroundColor = FNHomeBackgroundColor;
    
    [self.view addSubview:self.navigationView];
    [self.navigationView autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)excludingEdge:(ALEdgeBottom)];
    [self.navigationView autoSetDimension:(ALDimensionHeight) toSize:self.navigationView.height];
    
    @weakify(self)
    [self.view addSubview:self.searchView];
    self.searchView.delegate = self;
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@2);
        make.top.equalTo(self_weak_.navigationView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    UIView *vTitle = [[UIView alloc] init];
    [self.view addSubview:vTitle];
    [vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self_weak_.searchView.mas_bottom).offset(4);
        make.height.mas_equalTo(40);
    }];
    vTitle.backgroundColor = UIColor.whiteColor;
    
    UILabel *lblTitle = [[UILabel alloc] init];
    [vTitle addSubview:lblTitle];
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@10);
        make.right.equalTo(@-20);
    }];
    lblTitle.text = @"移除成员";
    lblTitle.font = kFONT16;
    lblTitle.textColor = RGB(38, 38, 38);
    
    
    self.view.backgroundColor = FNHomeBackgroundColor;
    self.jm_tableview = [[UITableView alloc]initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    self.jm_tableview.emptyDataSetSource = nil;
    self.jm_tableview.emptyDataSetDelegate = nil;
    self.jm_tableview.dataSource = self;
    self.jm_tableview.delegate = self;
    self.jm_tableview.alpha = 1;
    self.jm_tableview.backgroundColor = [UIColor clearColor];
    self.jm_tableview.estimatedRowHeight = 200;
    self.jm_tableview.rowHeight = UITableViewAutomaticDimension;
    self.jm_tableview.showsVerticalScrollIndicator = NO;
    self.jm_tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    
    self.jm_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.jm_tableview];
    @weakify(vTitle)
    [self.jm_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(vTitle_weak_.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
    [self.jm_tableview registerClass:[FNConnectionsHomeHeaderCell class] forHeaderFooterViewReuseIdentifier:@"FNConnectionsHomeHeaderCell"];
    [self.jm_tableview registerClass:[FNConnectionsHomeCell class] forCellReuseIdentifier:@"FNConnectionsHomeCell"];
    //    [self.jm_tableview registerClass:[FNMineIconsCell class] forCellReuseIdentifier:@"FNMineIconsCell"];
    //    [self.jm_tableview registerClass:[FNMineImageCell class] forCellReuseIdentifier:@"FNMineImageCell"];
    
    
    if (@available(iOS 11.0, *)) {
        self.jm_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self configHeader];
    
    [self requestMain];
}

- (void)configHeader {
    _imgHeader = [[UIImageView alloc] init];
    [self.view insertSubview:_imgHeader atIndex:0];
    @weakify(self)
    [_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        //        make.bottom.equalTo(self_weak_.headerView.mas_top).offset(HeaderOffset);
        make.bottom.equalTo(self_weak_.navigationView);
    }];
    _imgHeader.contentMode = UIViewContentModeScaleAspectFill;
    _imgHeader.layer.masksToBounds = YES;
}

#pragma mark - request
- (void)requestMain{
    
    self.jm_page = 1;
    [SVProgressHUD show];
    @weakify(self);
    [FNRequestTool startWithRequests:@[[self requestConnections]] withFinishedBlock:^(NSArray *erros) {
        @strongify(self);
        [SVProgressHUD dismiss];
        
        [self.jm_tableview reloadData];
    }];
}

- (FNRequestTool*) requestConnections{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken, @"p": @(self.jm_page), @"is_create": @"1", @"keyword": self.keyword}];
    if ([_qid kr_isNotEmpty]) {
        params[@"qid"] = _qid;
    }
    params[@"keyword"] = self.keyword;
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=all_team_list" respondType:(ResponseTypeArray) modelType:@"FNConnectionsMemberModel" success:^(id respondsObject) {
        @strongify(self);
        if (self.jm_page == 1) {
            [self.members removeAllObjects];
        }
        NSArray *array = respondsObject;
        if (array.count > 0)
            self.jm_page ++;
        
        [self.members addObjectsFromArray:respondsObject];
        
        [self.jm_tableview.mj_footer endRefreshing];
        [self.jm_tableview.mj_header endRefreshing];
        [self.jm_tableview reloadData];
    } failure:^(NSString *error) {
        //
    } isHideTips:YES isCache:NO];
}

- (FNRequestTool*) requestRemoveMembers {
    if (self.selectedMembers.count <= 0) {
        return nil;
    }
    [SVProgressHUD show];
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{TokenKey:UserAccessToken}];
    NSMutableString *ids = [[NSMutableString alloc] initWithString:self.selectedMembers.firstObject.uid];
    for (NSInteger index = 1; index < self.selectedMembers.count ; index ++) {
        [ids appendString:[NSString stringWithFormat:@",%@", self.selectedMembers[index].uid]];
    }
    params[@"uids"] = ids;
    params[@"qid"] = _qid;
    @weakify(self);
    return [FNRequestTool requestWithParams:params api:@"mod=appapi&act=connection_set&ctrl=more_retreat_qun" respondType:(ResponseTypeDataKey) modelType:@"" success:^(id respondsObject) {
        @strongify(self);
        
        [self.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    } isHideTips:NO];
}



#pragma mark - action
- (void)confirmAction{
    [self requestRemoveMembers];
}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadMoreData {
    [self requestConnections];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    return [[UITableViewCell alloc] init];
    FNConnectionsHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FNConnectionsHomeCell"];
    
    FNConnectionsMemberModel *model = self.members[indexPath.row];
    [cell.imgHeader sd_setImageWithURL:URL(model.head_img)];
    cell.lblTitle.text = model.nickname;

    [cell setIsShowCheck:YES];
    [cell setIsCheck:[self.selectedIds containsObject:model.uid]];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FNConnectionsMemberModel *model = self.members[indexPath.row];

    if ([self.selectedIds containsObject:model.uid]) {
        [self removeSelectedMember:model];
    } else {
        [self addSelectedMember:model];
    }
}

#pragma mark - selected mambers 处理
- (void) addSelectedMember: (FNConnectionsMemberModel*)member {
    
    [self.selectedIds addObject:member.uid];
    [self.selectedMembers addObject:member];
    NSMutableArray<NSString*>* icons = [[NSMutableArray alloc] init];
    for (FNConnectionsMemberModel *model in self.selectedMembers) {
        [icons addObject:model.head_img];
    }
    [self.searchView setIcons: icons];
    
    [self.jm_tableview reloadData];
    [self updateRightButton];
}

- (void) removeSelectedMember: (FNConnectionsMemberModel*)member {
    [self.selectedIds removeObject:member.uid];
    [self.selectedMembers removeObject:member];
    NSMutableArray<NSString*>* icons = [[NSMutableArray alloc] init];
    for (FNConnectionsMemberModel *model in self.selectedMembers) {
        [icons addObject:model.head_img];
    }
    [self.searchView setIcons: icons];
    
    [self.jm_tableview reloadData];
    [self updateRightButton];
}

- (void)updateRightButton {
    [self.confirmBtn setHidden:self.selectedIds.count == 0];
    [self.confirmBtn setTitle:[NSString stringWithFormat:@"确定(%ld)", self.selectedIds.count] forState:UIControlStateNormal];
}

#pragma mark - FNConnectionsSearchViewDelegate

- (void)searchView:(FNConnectionsSearchView *)searchView didItemSelectedAt:(NSInteger)index {
    FNConnectionsMemberModel *model = self.selectedMembers[index];
    [self removeSelectedMember:model];
}

- (void)searchView:(FNConnectionsSearchView *)searchView didSearch:(NSString *)keyword {
    [self.members removeAllObjects];
    self.jm_page = 1;
    self.keyword = keyword;
    [self requestConnections];
}

@end
