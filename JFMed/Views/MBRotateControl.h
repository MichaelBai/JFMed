//
//  MBRotateControl.h
//  JFMed
//
//  Created by Michael on 7/22/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBRotateDelegate

- (void)angleDidChangeTo:(CGFloat)angle;

@end

@interface MBRotateControl : UIControl

@property (nonatomic, weak) id delegate;

@end
