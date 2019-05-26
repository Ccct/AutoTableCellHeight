//
//  FDTemplateLayoutController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/26.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "FDTemplateLayoutController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "AutoHeightCell1TableViewCell.h"

@interface FDTemplateLayoutController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *cellData;

@end

@implementation FDTemplateLayoutController

/**
 第二种方式：FDTemplateLayout
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"FDTemplateLayout";
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell1TableViewCell" bundle:nil] forCellReuseIdentifier:[AutoHeightCell1TableViewCell reuseIdentifier]];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AutoHeightCell1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AutoHeightCell1TableViewCell reuseIdentifier] forIndexPath:indexPath];
    [self setCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    typeof(self) __weak weakSelf = self;
    
    //缓存高度
    return [self.tableView fd_heightForCellWithIdentifier:[AutoHeightCell1TableViewCell reuseIdentifier] cacheByIndexPath:indexPath configuration:^(id cell) {
        
        [weakSelf setCell:cell atIndexPath:indexPath];
    }];
    
    //不缓存高度
    //    return [self.tableView fd_heightForCellWithIdentifier:[AutoHeightCell1TableViewCell reuseIdentifier] configuration:^(id cell) {
    //
    //        [weakSelf setCell:cell atIndexPath:indexPath];
    //    }];
}

/// 配置cell
-(void)setCell:(AutoHeightCell1TableViewCell *)cell atIndexPath:(NSIndexPath *) indexPath{
    
    [cell loadCellData:self.cellData[indexPath.row]];
}

@end
