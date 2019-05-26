//
//  ViewController.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/21.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "ViewController.h"
#import "EstimatedHeightController.h"
#import "FDTemplateLayoutController.h"
#import "AutoLayoutCountHeightController.h"
#import "FrameLayoutCountHeightController.h"
#import "YYKitController.h"
#import "AsyncDisplayKitiController.h"



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)EstimateAction:(id)sender {
    
    EstimatedHeightController *vc = [EstimatedHeightController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FDTemplateAction:(id)sender {
    
    FDTemplateLayoutController *vc = [FDTemplateLayoutController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)AutoLayoutCountHeightAction:(id)sender {
    
    AutoLayoutCountHeightController *vc = [AutoLayoutCountHeightController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)FrameLayoutHeight:(id)sender {
    
    FrameLayoutCountHeightController *vc = [FrameLayoutCountHeightController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)YYKitCountHeightAction:(id)sender {
    
    YYKitController *vc = [YYKitController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)AsyncDisplayKitAction:(id)sender {

    AsyncDisplayKitiController *vc = [AsyncDisplayKitiController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
