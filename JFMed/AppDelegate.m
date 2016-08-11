//
//  AppDelegate.m
//  JFMed
//
//  Created by Michael on 7/18/16.
//  Copyright (c) 2016 MichaelBai. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "HomeViewController.h"
#import "MessageListViewController.h"
#import "SelfCheckViewController.h"
#import "PersonalViewController.h"

static NSString * const kHomeTabName = @"Home";
static NSString * const kMessageTabName = @"Message";
static NSString * const kCheckTabName = @"Check";
static NSString * const kMyTabName = @"My";

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
#if DEBUG
    [self debugHTTP];
#endif
    
    [self customAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [self setupTabbar];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
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

#pragma mark - appearance

- (void)customAppearance
{
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage* image = [UIImage imageNamed:@"back-icon"];
    image = [image stretchableImageWithLeftCapWidth:image.size.width topCapHeight:0];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

#pragma mark - tab bar

- (UINavigationController *)naviControllerWithName:(NSString *)name
{
    UIEdgeInsets tabBarItemInset = UIEdgeInsetsMake(5, 0, -5, 0);
    if ([name isEqualToString:kHomeTabName]) {
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        
        homeVC.tabBarItem.image = [[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        homeVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_home_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        homeVC.tabBarItem.imageInsets = tabBarItemInset;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
        return nav;
    } else if ([name isEqualToString:kMessageTabName]){
        MessageListViewController *messageListVC = [[MessageListViewController alloc] init];
        
        messageListVC.tabBarItem.image = [[UIImage imageNamed:@"tab_msg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        messageListVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_msg_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        messageListVC.tabBarItem.imageInsets = tabBarItemInset;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:messageListVC];
        return nav;
    } else if ([name isEqualToString:kCheckTabName]){
        SelfCheckViewController *checkVC = [[SelfCheckViewController alloc] init];
        
        checkVC.tabBarItem.image = [[UIImage imageNamed:@"tab_check"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        checkVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_check_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        checkVC.tabBarItem.imageInsets = tabBarItemInset;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:checkVC];
        return nav;
    } else if ([name isEqualToString:kMyTabName]){
        PersonalViewController *personalVC = [[PersonalViewController alloc] init];
        
        personalVC.tabBarItem.image = [[UIImage imageNamed:@"tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        personalVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_my_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        personalVC.tabBarItem.imageInsets = tabBarItemInset;
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:personalVC];
        return nav;
    } else {
        WelcomeViewController *loginVC = [[WelcomeViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        return nav;
    }
}

- (UITabBarController *)setupTabbar
{
    UINavigationController *homeNav = [self naviControllerWithName:kHomeTabName];
    UINavigationController *messageNav = [self naviControllerWithName:kMessageTabName];
    UINavigationController *checkNav = [self naviControllerWithName:kCheckTabName];
    UINavigationController *myNav = [self naviControllerWithName:kMyTabName];
    
    NSArray *tabControllers = @[homeNav, messageNav, checkNav, myNav];
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = tabControllers;
    [tabController.tabBar setTintColor:[UIColor redColor]];
    tabController.delegate = self;
    
    return tabController;
}

#pragma mark - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
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
