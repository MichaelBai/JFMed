//
//  MessageTableViewCell.m
//  JFMed
//
//  Created by Michael on 7/25/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "MessageTableViewCell.h"

@interface MessageTableViewCell ()

@property (nonatomic, strong) UIImageView *docImage;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _docImage = [UIImageView new];
        [self.contentView addSubview:_docImage];
        _docImage.backgroundColor = HEXColor(0xeaeaea);
        
        _nameLabel = [UILabel new];
        [self.contentView addSubview:_nameLabel];
        _nameLabel.textColor = COLOR_TITLE;
        _nameLabel.font = FONT_(16);
        
        _dateLabel = [UILabel new];
        [self.contentView addSubview:_dateLabel];
        _dateLabel.textColor = COLOR_NOTICE;
        _dateLabel.font = FONT_(12);
        
        _messageLabel = [UILabel new];
        [self.contentView addSubview:_messageLabel];
        _messageLabel.textColor = COLOR_NOTICE;
        _messageLabel.font = FONT_(13);
        
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
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_docImage.mas_right).offset(10);
            make.bottom.equalTo(@-12);
            make.right.equalTo(@-10);
        }];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.centerY.equalTo(_nameLabel);
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
    _dateLabel.text = @"昨天";
    _messageLabel.text = @"请您提供家族病史，往年病例，谢谢。";
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
