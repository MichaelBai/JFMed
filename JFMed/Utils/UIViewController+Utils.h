//
//  UIViewController+Utils.h
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

- (void)addLeftBarButtonWithTitle:(NSString*)title
                           image:(UIImage*)image
                 backgroundImage:(UIImage*)background
                          action:(SEL)action;

- (void)addRightBarButtonWithTitle:(NSString*)title
                            image:(UIImage*)image
                  backgroundImage:(UIImage*)background
                           action:(SEL)action;

@end
