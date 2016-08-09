//
//  SelfCheckTableViewCell.m
//  JFMed
//
//  Created by Michael on 8/9/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckTableViewCell.h"

@implementation SelfCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _icon = [UIImageView new];
        [self.contentView addSubview:_icon];
        
        _date = [UILabel new];
        [self.contentView addSubview:_date];
        _date.textColor = COLOR_TITLE;
        _date.font = FONT_(16);
        
        _angle = [UILabel new];
        [self.contentView addSubview:_angle];
        _angle.textColor = COLOR_TITLE;
        _angle.font = FONT_(16);
        
        _selectBtn = [UIButton new];
        [self.contentView addSubview:_selectBtn];
        [_selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = COLOR_LINE;
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@0);
            make.width.equalTo(@55);
            make.height.equalTo(@75);
        }];
        [_date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_icon.mas_right).offset(35);
            make.centerY.equalTo(@0);
        }];
        [_angle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_date.mas_right).offset(35);
            make.centerY.equalTo(@0);
        }];
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
            make.centerY.equalTo(@0);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.bottom.right.equalTo(@0);
        }];
    }
    return self;
}

- (void)setData
{
    [_icon sd_setImageWithURL:[NSURL URLWithString:@""]];
    _date.text = @"2016.3.24";
    _angle.text = @"约18度";
}

+ (CGFloat)CellHeight
{
    return 100;
}

@end
