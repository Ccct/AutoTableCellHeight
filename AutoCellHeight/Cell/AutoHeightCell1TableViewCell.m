//
//  AutoHeightCell1TableViewCell.m
//  AutoCellHeight
//
//  Created by Helios on 2019/5/21.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import "AutoHeightCell1TableViewCell.h"

@interface AutoHeightCell1TableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgeView;

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (weak, nonatomic) IBOutlet UILabel *desText;


@end

@implementation AutoHeightCell1TableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)loadCellData:(NSDictionary *)data{
    
    NSString *titleText = [data objectForKey:@"title"];
    NSString *desText = [data objectForKey:@"desText"];
    self.titleLab.text = titleText;
    self.desText.text = desText;
    self.imgeView.image = [UIImage imageNamed:@"cellImage"];
}

@end
