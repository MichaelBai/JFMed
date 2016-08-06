//
//  AppDelegate.h
//  JFMed
//
//  Created by Michael on 7/18/16.
//  Copyright (c) 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *accessToken;

- (void)showLogin;

@end

