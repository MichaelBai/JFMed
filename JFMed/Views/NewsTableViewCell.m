//
//  NewsTableViewCell.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "NewsTableViewCell.h"

@interface NewsTableViewCell ()

@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIImageView *handImage;
@property (nonatomic, strong) UILabel *handLabel;
@property (nonatomic, strong) UIImageView *heartImage;
@property (nonatomic, strong) UILabel *heartLabel;

@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _newsImage = [UIImageView new];
        [self.contentView addSubview:_newsImage];
        _newsImage.backgroundColor = HEXColor(0xeaeaea);
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = HEXColor(0x222222);
        _titleLabel.font = FONT_(15);
        
        _authorLabel = [UILabel new];
        [self.contentView addSubview:_authorLabel];
        _authorLabel.textColor = HEXColor(0x999999);
        _authorLabel.font = FONT_(13);
        
        _handImage = [UIImageView new];
        [self.contentView addSubview:_handImage];
        
        _handLabel = [UILabel new];
        [self.contentView addSubview:_handLabel];
        _handLabel.textColor = HEXColor(0x999999);
        _handLabel.font = FONT_(12);
        
        _heartImage = [UIImageView new];
        [self.contentView addSubview:_heartImage];
        
        _heartLabel = [UILabel new];
        [self.contentView addSubview:_heartLabel];
        _heartLabel.textColor = HEXColor(0x999999);
        _heartLabel.font = FONT_(12);
        
        UIView *lineView = [UIView new];
        [self.contentView addSubview:lineView];
        lineView.backgroundColor = HEXColor(0xeaeaea);
        
        [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@12.5);
            make.width.equalTo(@93);
            make.height.equalTo(@70);
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_newsImage.mas_right).offset(10);
            make.top.equalTo(@13);
            make.right.equalTo(@-10);
        }];
        [_authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_newsImage.mas_right).offset(10);
            make.bottom.equalTo(@-13);
        }];
        [_heartLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-13);
        }];
        [_heartImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_heartLabel.mas_left).offset(-5);
            make.centerY.equalTo(_heartLabel);
        }];
        [_handLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_heartImage.mas_left).offset(-20);
            make.centerY.equalTo(_heartLabel);
        }];
        [_handImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_handLabel.mas_left).offset(-5);
            make.centerY.equalTo(_heartLabel);
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
    [_newsImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"news"]];
    _titleLabel.text = @"脊柱侧弯到底是怎样一种病？是怎样引起的？";
    _authorLabel.text = @"脊诊室主编";
    _handLabel.text = @"123";
    _heartLabel.text = @"43";
}

+ (CGFloat)CellHeight
{
    return 95;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
