//
//  EstimatedHeightController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/26.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "EstimatedHeightController.h"
#import "AutoHeightCell1TableViewCell.h"

@interface EstimatedHeightController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *cellData;

@end

@implementation EstimatedHeightController

/**
 第一种方式：estimatedHeight
 */
/// 注意这个高度要尽量接近，estimatedHeightForRowAtIndexPath 这个代理方法走完后还会走 heightForRowAtIndexPath
/// 要在tableview初始化的时候加 _tableView.rowHeight  = UITableViewAutomaticDimension;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EstimatedHeight";
    [self.view addSubview:self.tableView];
    
    self.cellData = [NSMutableArray arrayWithArray:@[@{@"title":@"xxxx",@"desText":@"aaaaaaaaaa"},
                                                     @{@"title":@"xxxx",@"desText":@"1121212121211212121212121324123213123123131233123"},
                                                     @{@"title":@"xxxx",@"desText":@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"},
                                                     @{@"title":@"xxxx",@"desText":@"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasdsadsadasdasdasdasdsada"},
                                                     @{@"title":@"xxxx",@"desText":@"sssssssssssssdssfafadaetadsdfadsfafadsfadfadfafdsafasfadsadsfadsfadfafafadfadsfadfadsdfafafasdfdsfasfasfasdfasdffafafdadfadfadfadfadadfasdf"},
                                                     @{@"title":@"xxxx",@"desText":@"sssssssssssssdssfafadaetadsdfadsfafadsfadfadfafdsafasfadsadsfadsfadfafafadfadsfadfadsdfafafasdfdsfasfasfasdfasdffafafdadfadfadfadfadadfasdfdafadfasfafadsfadsfadsfadsfsddass"},
                                                     @{@"title":@"xxxx",@"desText":@"sssssssssssssdssfafadaetadsdfadsfafadsfadfadfafdsafasfadsadsfadsfadfafafadfadsfadfadsdfafafasdfdsfasfasfasdfasdffafafdadfadfadfadfadadfasdfdafadfasfafadsfadsfadsfadsfsddassdfafadsfasdfdfasfadsfasfasdfasdfasfasdfasdfasd"}]];
}


- (UITableView*)tableView{
    if(!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        _tableView.backgroundColor =[UIColor whiteColor];
        _tableView.delegate   =self;
        _tableView.dataSource =self;
        _tableView.rowHeight  = UITableViewAutomaticDimension; //注意这里要这样写
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
        [_tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell1TableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([AutoHeightCell1TableViewCell class])];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AutoHeightCell1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AutoHeightCell1TableViewCell class]) forIndexPath:indexPath];
    [cell loadCellData:self.cellData[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 50;
}

@end
