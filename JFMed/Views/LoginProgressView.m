//
//  LoginProgressView.m
//  JFMed
//
//  Created by Michael on 7/25/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "LoginProgressView.h"

@interface LoginProgressView ()

@property (nonatomic, strong) NSMutableArray *progressImages;

@end

@implementation LoginProgressView

- (instancetype)initWithFrame:(CGRect)frame progressCount:(NSInteger)progressCount
{
    self = [super initWithFrame:frame];
    if (self) {
        // 暂时要求frame宽度为SCREEN_WIDTH,高度为20
        UIView *bgLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 7.5, SCREEN_WIDTH, 5)];
        bgLineView.backgroundColor = HEXColor(0xe6eaf3);
        [self addSubview:bgLineView];
        
        // 这里的宽度来源于设计图
        CGFloat gapWidth = 31;
        if (progressCount == 3) {
            gapWidth = 58;
        }
        CGFloat offsetX = (SCREEN_WIDTH - 20 * progressCount - gapWidth * (progressCount - 1)) / 2;
        _progressImages = [NSMutableArray array];
        for (int i = 0; i < progressCount; i++) {
            UIImageView *progressImage = [[UIImageView alloc] initWithFrame:CGRectMake(offsetX, 0, 20, 20)];
            progressImage.image = [UIImage imageNamed:@"login_circle_gray"];
            [self addSubview:progressImage];
            [_progressImages addObject:progressImage];
            offsetX += 20 + gapWidth;
        }
    }
    return self;
}

- (void)setProgressIndex:(NSInteger)progressIndex
{
    _progressIndex = progressIndex;
    if (progressIndex >= 0 && progressIndex < _progressImages.count) {
        for (int i = 0; i < _progressImages.count; i++) {
            if (i < progressIndex) {
                [_progressImages[i] setImage:[UIImage imageNamed:@"login_check"]];
            } else if (i == progressIndex) {
                [_progressImages[i] setImage:[UIImage imageNamed:@"login_circle_green"]];
            } else {
                [_progressImages[i] setImage:[UIImage imageNamed:@"login_circle_gray"]];
            }
        }
    }
}

@end
