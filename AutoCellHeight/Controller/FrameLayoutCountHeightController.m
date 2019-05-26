//
//  FrameLayoutCountHeightController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/26.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "FrameLayoutCountHeightController.h"
#import "DataSupport.h"
#import "FrameLayoutTableViewCell.h"

@interface FrameLayoutCountHeightController ()

<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) DataSupport *dataSupport;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FrameLayoutCountHeightController

/**
 最推荐：
 第四种方式：FrameLayout + CountHeight
 直接使用Frame来布局，这样就减少了由AutoLayout转换到FrameLayout的时间。效果还是蛮OK的。虽然有些掉帧，但是还是非常流畅的。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FrameLayout+CountHeight";
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
        [self.tableView registerClass:[FrameLayoutTableViewCell class] forCellReuseIdentifier:@"FrameLayoutTableViewCellid"];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FrameLayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FrameLayoutTableViewCellid" forIndexPath:indexPath];
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
