//
//  AsyncDisplayKitiController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/26.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "AsyncDisplayKitiController.h"
#import "AsyncDisplayKitTableViewCell.h"
#import "DataSupport.h"

@interface AsyncDisplayKitiController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) DataSupport *dataSupport;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AsyncDisplayKitiController

/**
 最流畅，几乎不掉帧
 第五种方式：AsyncDisplayKit + CountHeight
 将我们使用到的组件替换成AsyncDisplayKit相应的Note，如下所示。这些Note是对系统组件的重组，对组件的显示进行了优化，让其渲染更为流畅。不过会严重依赖AsyncDisplayKit。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AsyncDisplayKit + CountHeight";
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
        [self.tableView registerClass:[AsyncDisplayKitTableViewCell class] forCellReuseIdentifier:@"AsyncDisplayKitTableViewCellid"];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AsyncDisplayKitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AsyncDisplayKitTableViewCellid" forIndexPath:indexPath];
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
