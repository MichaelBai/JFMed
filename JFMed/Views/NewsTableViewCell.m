//
//  NewsTableViewCell.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "HomeModel.h"

@interface NewsTableViewCell ()

@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UIButton *handImage;
@property (nonatomic, strong) UILabel *handLabel;
@property (nonatomic, strong) UIButton *heartImage;
@property (nonatomic, strong) UILabel *heartLabel;

@end

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _newsImage = [UIImageView new];
        [self.contentView addSubview:_newsImage];
        _newsImage.backgroundColor = HEXColor(0xeaeaea);
        _newsImage.contentMode = UIViewContentModeScaleAspectFill;
        _newsImage.clipsToBounds = YES;
        
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.textColor = HEXColor(0x222222);
        _titleLabel.font = FONT_(15);
        _titleLabel.numberOfLines = 2;
        
        _authorLabel = [UILabel new];
        [self.contentView addSubview:_authorLabel];
        _authorLabel.textColor = HEXColor(0x999999);
        _authorLabel.font = FONT_(13);
        
        _handImage = [UIButton new];
        [self.contentView addSubview:_handImage];
        [_handImage setImage:[UIImage imageNamed:@"zan_gray"] forState:UIControlStateNormal];
        [_handImage setImage:[UIImage imageNamed:@"zan_red"] forState:UIControlStateSelected];
        
        _handLabel = [UILabel new];
        [self.contentView addSubview:_handLabel];
        _handLabel.textColor = HEXColor(0x999999);
        _handLabel.font = FONT_(12);
        
        UIView *handClickView = [UIView new];
        [self.contentView addSubview:handClickView];
        [handClickView addTapAction:@selector(handClick) target:self];
        
        _heartImage = [UIButton new];
        [self.contentView addSubview:_heartImage];
        [_heartImage setImage:[UIImage imageNamed:@"heart_gray"] forState:UIControlStateNormal];
        [_heartImage setImage:[UIImage imageNamed:@"heart_red"] forState:UIControlStateSelected];
        
        _heartLabel = [UILabel new];
        [self.contentView addSubview:_heartLabel];
        _heartLabel.textColor = HEXColor(0x999999);
        _heartLabel.font = FONT_(12);
        
        UIView *heartClickView = [UIView new];
        [self.contentView addSubview:heartClickView];
        [heartClickView addTapAction:@selector(heartClick) target:self];
        
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
        [heartClickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_heartImage).offset(-10);
            make.right.equalTo(_heartLabel);
            make.top.equalTo(_heartImage).offset(-5);
            make.bottom.equalTo(_heartImage).offset(5);
        }];
        [_handLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_heartImage.mas_left).offset(-20);
            make.centerY.equalTo(_heartLabel);
        }];
        [_handImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_handLabel.mas_left).offset(-5);
            make.centerY.equalTo(_heartLabel);
        }];
        [handClickView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_handImage).offset(-10);
            make.right.equalTo(_handLabel);
            make.top.equalTo(_handImage).offset(-5);
            make.bottom.equalTo(_handImage).offset(5);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-0.5);
            make.left.and.right.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}

- (void)setDataWithNews:(HomeNews *)news
{
    [_newsImage sd_setImageWithURL:[NSURL URLWithString:news.img] placeholderImage:[UIImage imageNamed:@"news"]];
    _titleLabel.attributedText = [CommonUtility getAttributedStringWithString:news.content lineSpace:5 font:FONT_(15) alignment:NSTextAlignmentLeft];
    _authorLabel.text = news.source;
    _handLabel.text = @(news.like_count).stringValue;
    _heartLabel.text = @(news.heart_count).stringValue;
}

+ (CGFloat)CellHeight
{
    return 95;
}

- (void)handClick
{
    _handImage.selected = !_handImage.selected;
}

- (void)heartClick
{
    _heartImage.selected = !_heartImage.selected;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
