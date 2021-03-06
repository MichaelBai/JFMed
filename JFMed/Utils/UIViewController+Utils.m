//
//  UIViewController+Utils.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

- (void)addLeftBarButtonWithTitle:(NSString*)title
                           image:(UIImage*)image
                 backgroundImage:(UIImage*)background
                          action:(SEL)action{
    UIBarButtonItem* left;
    
    if ([title length]) {
        left = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    } else if (image) {
        UIImage* originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        left = [[UIBarButtonItem alloc] initWithImage:originalImage style:UIBarButtonItemStylePlain target:self action:action];
    }
    if (background) {
        [left setBackgroundImage:background forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    self.navigationItem.leftBarButtonItem = left;
}

- (void)addRightBarButtonWithTitle:(NSString*)title
                            image:(UIImage*)image
                  backgroundImage:(UIImage*)background
                           action:(SEL)action{
    UIBarButtonItem* right;
    
    if ([title length]) {
        right = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    } else if (image) {
        UIImage* originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        right = [[UIBarButtonItem alloc] initWithImage:originalImage style:UIBarButtonItemStylePlain target:self action:action];
    }
    if (background) {
        [right setBackgroundImage:background forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    self.navigationItem.rightBarButtonItem = right;
}

- (void)setTitle:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = COLOR_NAV;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = FONT_(20);
    titleLabel.text = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

@end
