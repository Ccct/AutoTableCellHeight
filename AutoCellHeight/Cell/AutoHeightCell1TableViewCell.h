//
//  AutoHeightCell1TableViewCell.h
//  AutoCellHeight
//
//  Created by Helios on 2019/5/21.
//  Copyright © 2019 陈楚涛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AutoHeightCell1TableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

-(void)loadCellData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
