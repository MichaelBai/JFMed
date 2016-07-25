//
//  MBTabView.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "MBTabView.h"

#define Multiplier_Scale (SCREEN_WIDTH/320)

@interface MBTabView ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIView *sliderView;

@end

@implementation MBTabView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addLine];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)addLine
{
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(-1000, self.frame.size.height - 0.5, 2000, 0.5)];
    line.backgroundColor = COLOR_LINE;
    [self addSubview:line];
}

#pragma mark - Lazy load

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

#pragma mark - Layout

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    [self clearButtons];
    [self createButtons];
    [self createSlider];
    [self layoutButtons];
    [self layoutSlider];
    if (_titles.count > 4) {
        CGFloat averageWidth = SCREEN_WIDTH / 4.5;
        self.contentSize = CGSizeMake(averageWidth * _titles.count, self.frame.size.height);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (_buttons.count > 0) {
        [self layoutButtons];
        [self layoutSlider];
    }
}

- (void)clearButtons
{
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [self.buttons removeAllObjects];
}

- (void)createButtons
{
    if (self.titles) {
        for (int i = 0; i<self.titles.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[self.titles objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitle:[self.titles objectAtIndex:i] forState:UIControlStateHighlighted];
            [btn setTitle:[self.titles objectAtIndex:i] forState:UIControlStateSelected];
            btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [btn addTarget:self action:@selector(tabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = FONT_(16);
            [btn setTitleColor:COLOR_TITLE forState:UIControlStateNormal];
            [btn setTitleColor:COLOR_THEME forState:UIControlStateSelected];
            if (_isThinnerStyle) {
                btn.titleLabel.font = FONT_(12);
                [btn setTitleColor:COLOR_NOTICE forState:UIControlStateNormal];
            }
            btn.tag = i;
            [self addSubview:btn];
            [self.buttons addObject:btn];
        }
    }

}

- (void)createSlider
{
    _sliderView = [[UIView alloc] init];
    _sliderView.backgroundColor = COLOR_THEME;
    _sliderView.tag = 10;
    [self addSubview:_sliderView];
}

- (void)layoutButtons
{
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = (UIButton *)obj;
        btn.frame = [self frameForButtonAtIndex:idx];
        if (idx == self.selectedIndex) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }];
}

- (void)layoutSlider
{
    _sliderView.frame = [self frameForSliderAtIndex:self.selectedIndex];
}

#pragma mark - helper

- (CGRect)frameForButtonAtIndex:(NSUInteger)index
{
    // specify button frame when it has 2 titles
    if (self.titles.count == 2) {
        if (index == 0) {
            return CGRectMake(SCREEN_WIDTH/2 - (97 + 13)*Multiplier_Scale, 0, 97*Multiplier_Scale, self.frame.size.height);
        } else {
            return CGRectMake(SCREEN_WIDTH/2 + 13*Multiplier_Scale, 0, 97*Multiplier_Scale, self.frame.size.height);
        }
    }

    CGFloat averageWidth = SCREEN_WIDTH/self.titles.count;
    if (_titles.count > 4) {
        averageWidth = SCREEN_WIDTH / 4.5;
    }
    CGRect frame = CGRectMake(index*averageWidth, 0, averageWidth, self.frame.size.height);
    return frame;
}

- (CGRect)frameForSliderAtIndex:(NSUInteger)index
{
    NSUInteger sliderWidth = 85; // 85 is from design
    if (self.buttons.count > 3) {
        sliderWidth = 66;  // 66 is from design for 4 buttons
    }
    UIButton *button = [self.buttons objectAtIndex:index];
    
    // 这里将Rect取值为整数，是为了防止float值和屏幕像素对不上的时候slider的动画不出现
    NSInteger width = (button.frame.size.width < sliderWidth)? button.frame.size.width : sliderWidth;
    NSInteger height = 3;
    NSInteger x = ceil((button.frame.size.width < sliderWidth)? button.frame.origin.x : button.frame.origin.x + (button.frame.size.width-sliderWidth)/2);
    NSInteger y = self.frame.size.height-height;
    
    if (_isThinnerStyle) {
        y = self.frame.size.height - 8;
        width = [button.titleLabel.text boundingRectWithFont:FONT_(12) andSize:CGSizeMake(CGFLOAT_MAX, 20)].width;
        x = button.frame.origin.x + (button.frame.size.width-width)/2;
    }
    return CGRectMake(x, y, width, height);
}

#pragma mark - action

- (void)tabButtonClicked:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger index = button.tag;
    [self.buttons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = (UIButton *)obj;
        if (idx==index) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }];
    
    [UIView animateWithDuration:0.4 animations:^{
        _sliderView.frame = [self frameForSliderAtIndex:index];
    } completion:^(BOOL finished) {
        if (self.btnClickDelegate &&
            [self.btnClickDelegate conformsToProtocol:@protocol(MBTabViewButtonClickDelegate)] &&
            [self.btnClickDelegate respondsToSelector:@selector(MBTabView:didClickButtonAtIndex:)]) {
            [self.btnClickDelegate MBTabView:self didClickButtonAtIndex:index];
        }
    }];
}

@end
