//
//  PersonalTableViewCell.m
//  JFMed
//
//  Created by Michael on 7/30/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "PersonalTableViewCell.h"

@interface PersonalTableViewCell ()

@end

@implementation PersonalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _icon = [UIImageView new];
        [self.contentView addSubview:_icon];
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = COLOR_NAV;
        _titleLabel.font = FONT_(16);
        
        _subTitleLabel = [UILabel new];
        _subTitleLabel.textColor = COLOR_NAV;
        _subTitleLabel.font = FONT_(12);
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_subTitleLabel];
        
        UIImageView *arrowView = [UIImageView new];
        [self.contentView addSubview:arrowView];
        arrowView.image = [UIImage imageNamed:@"arrow"];
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = COLOR_LINE;
        
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@0);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_icon.mas_right).offset(8);
            make.centerY.equalTo(@0);
        }];
        [_subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowView.mas_left).offset(-10);
            make.centerY.equalTo(@0);
        }];
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
            make.centerY.equalTo(@0);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.bottom.right.equalTo(@0);
        }];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
