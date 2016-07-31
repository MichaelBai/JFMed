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
        _icon = [UIImageView new];
        [self.contentView addSubview:_icon];
        _icon.backgroundColor = HEXColor(0xeaeaea);
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = HEXColor(0x555c70);
        _titleLabel.font = FONT_(16);
        
        UIImageView *arrowView = [UIImageView new];
        [self.contentView addSubview:arrowView];
        arrowView.image = [UIImage imageNamed:@""];
        
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
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
            make.centerY.equalTo(@0);
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
