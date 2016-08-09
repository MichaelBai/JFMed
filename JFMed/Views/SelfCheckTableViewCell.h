//
//  SelfCheckTableViewCell.h
//  JFMed
//
//  Created by Michael on 8/9/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfCheckTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *date;
@property (nonatomic, strong) UILabel *angle;
@property (nonatomic, strong) UIButton *selectBtn;

+ (CGFloat)CellHeight;
- (void)setData;

@end
