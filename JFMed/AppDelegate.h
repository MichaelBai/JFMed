//
//  AppDelegate.h
//  JFMed
//
//  Created by Michael on 7/18/16.
//  Copyright (c) 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UserInfo *userInfo;

- (void)showLogin;

@end

