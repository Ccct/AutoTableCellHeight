//
//  CountHeightController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/26.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "AutoLayoutCountHeightController.h"
#import "DataSupport.h"
#import "AutolayoutTableViewCell.h"

@interface AutoLayoutCountHeightController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) DataSupport *dataSupport;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AutoLayoutCountHeightController

/**
 第三种方式：Autolayout +CountHeight
 使用AutoLayout布局，并且在子线程中计算Cell高度，卡顿问题会得到些微的解决。稍微好一些，不过掉帧也是比较严重的
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AutoLayout+CountHeight";
    [self.view addSubview:self.tableView];
    [self createDataSupport];
}

- (UITableView*)tableView{
    if(!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.delegate   =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //优化tableview
        _tableView.delaysContentTouches = NO;
        _tableView.canCancelContentTouches = YES;
        UIView *wrapView = self.tableView.subviews.firstObject;
        if (wrapView && [NSStringFromClass(wrapView.class) hasSuffix:@"WrapperView"]) {
            for (UIGestureRecognizer *gesture in wrapView.gestureRecognizers) {
                if ([NSStringFromClass(gesture.class) containsString:@"DelayedTouchesBegan"] ) {
                    gesture.enabled = NO;
                    break;
                }
            }
        }
        //注册cell
        [self.tableView registerNib:[UINib nibWithNibName:@"AutolayoutTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AutolayoutTableViewCellid"];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AutolayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutolayoutTableViewCellid" forIndexPath:indexPath];
    [cell configCellData:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    TestDataModel *model = self.dataSource[indexPath.row];
    return model.cellHeight;
}

- (void)createDataSupport {
    
    self.dataSupport = [[DataSupport alloc] init];
    __weak typeof (self) weak_self = self;
    [self.dataSupport setUpdataDataSourceBlock:^(NSMutableArray *dataSource) {
        weak_self.dataSource = dataSource;
        [weak_self.tableView reloadData];
    }];
    [self.dataSupport addTestData];
}

@end
