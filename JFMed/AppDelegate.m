//
//  AppDelegate.m
//  JFMed
//
//  Created by Michael on 7/18/16.
//  Copyright (c) 2016 MichaelBai. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
#if DEBUG
    [self debugHTTP];
#endif
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage* image = [UIImage imageNamed:@"back-icon"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width topCapHeight:0];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    return YES;
}

- (void)debugHTTP
{
#if DEBUG
    [self debugApiPath:@"/home/data" filePath:@"home_data.json"];
    [self debugApiPath:@"/news/list" filePath:@"news_list.json"];
    [self debugApiPath:@"/doctor/list" filePath:@"doctor_list.json"];
    [self debugApiPath:@"/doctor/group" filePath:@"doctors_group.json"];
    [self debugApiPath:@"/news/group" filePath:@"news_group.json"];
#endif
}

- (void)debugApiPath:(NSString *)apiPath filePath:(NSString *)filePath
{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.path isEqualToString:apiPath];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        // Stub it with our "wsresponse.json" stub file
        return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFile(filePath,self.class)
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    if (self.userInfo) {
        NSDictionary *jsonDic = [MTLJSONAdapter JSONDictionaryFromModel:self.userInfo error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:jsonDic forKey:@"kUserInfo"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSDictionary *jsonDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserInfo"];
    if (jsonDic) {
        UserInfo *userInfo = [MTLJSONAdapter modelOfClass:[UserInfo class] fromJSONDictionary:jsonDic error:nil];
        if (userInfo) {
            self.userInfo = userInfo;
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)showLogin
{
    WelcomeViewController *loginVC = [[WelcomeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.window.rootViewController presentViewController:nav animated:YES completion:nil];
}

@end
