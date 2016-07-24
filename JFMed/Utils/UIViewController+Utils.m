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
    }else if (image){
        left = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:action];
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
    }else if (image){
        UIImage* originalImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        right = [[UIBarButtonItem alloc] initWithImage:originalImage style:UIBarButtonItemStylePlain target:self action:action];
    }
    if (background) {
        [right setBackgroundImage:background forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    }
    
    self.navigationItem.rightBarButtonItem = right;
}

@end
