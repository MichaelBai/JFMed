//
//  LoginProgressView.h
//  JFMed
//
//  Created by Michael on 7/25/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginProgressView : UIView

@property (nonatomic, assign) NSInteger progressIndex;

- (instancetype)initWithFrame:(CGRect)frame progressCount:(NSInteger)progressCount;

@end
