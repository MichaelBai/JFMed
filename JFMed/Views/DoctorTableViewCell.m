//
//  DoctorTableViewCell.m
//  JFMed
//
//  Created by Michael on 7/25/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "DoctorTableViewCell.h"

@interface DoctorTableViewCell ()

@property (nonatomic, strong) UIImageView *docImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *hospitalLabel;
@property (nonatomic, strong) UILabel *levelLabel;
@property (nonatomic, strong) UILabel *advisoryLabel;

@end

@implementation DoctorTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _docImage = [UIImageView new];
        [self.contentView addSubview:_docImage];
        _docImage.backgroundColor = HEXColor(0xeaeaea);
        
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textColor = COLOR_TITLE;
        _nameLabel.font = FONT_(16);
        
        _hospitalLabel = [UILabel new];
        [self.contentView addSubview:_hospitalLabel];
        _hospitalLabel.textColor = HEXColor(0x999999);
        _hospitalLabel.font = FONT_(13);
        
        _levelLabel = [UILabel new];
        [self.contentView addSubview:_levelLabel];
        _levelLabel.textColor = HEXColor(0x999999);
        _levelLabel.font = FONT_(13);
        
        _advisoryLabel = [UILabel new];
        [self.contentView addSubview:_advisoryLabel];
        _advisoryLabel.textColor = HEXColor(0x999999);
        _advisoryLabel.font = FONT_(13);
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = HEXColor(0xeaeaea);
        
        [_docImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(@0);
            make.width.equalTo(@55);
            make.height.equalTo(@55);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_docImage.mas_right).offset(10);
            make.top.equalTo(@13);
            make.right.equalTo(@-10);
        }];
        [_hospitalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_docImage.mas_right).offset(10);
            make.bottom.equalTo(@-12);
            make.width.lessThanOrEqualTo(@120);
        }];
        [_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_hospitalLabel.mas_right).offset(8);
            make.centerY.equalTo(_hospitalLabel);
        }];
        [_advisoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(@0);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-0.5);
            make.left.and.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (void)setData
{
    [_docImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"docHead"]];
    _nameLabel.text = @"赵一铭";
    _hospitalLabel.text = @"北京协和医院";
    _levelLabel.text = @"主任医师";
    _advisoryLabel.text = @"147次咨询";
}

+ (CGFloat)CellHeight
{
    return 66;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
