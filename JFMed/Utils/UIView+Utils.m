//
//  UIView+Utils.m
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "UIView+Utils.h"
#import "UIView+Toast.h"

@implementation UIView (Utils)

- (void)addTapAction:(SEL)selector target:(id)target
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapGesture];
}

- (void)removeAllSubViews
{
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
}

- (void)showToast:(NSString *)toast
{
    [self makeToast:toast duration:1.0 position:CSToastPositionCenter];
}

@end
