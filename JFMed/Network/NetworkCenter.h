//
//  NetworkCenter.h
//  JFMed
//
//  Created by Michael on 7/31/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorUserInfoMsgKey            @"errorMsg"         // 错误Key

typedef void (^NetworkCompletionHandler)(id response, NSError* error, BOOL updatePage);

@interface NetworkCenter : NSObject

+ (instancetype)sharedCenter;

- (void)postWithApiPath:(NSString *)apiPath
          requestParams:(NSDictionary *)requestParams
                handler:(NetworkCompletionHandler)handler;

- (void)getWithApiPath:(NSString *)apiPath
         requestParams:(NSDictionary *)requestParams
               handler:(NetworkCompletionHandler)handler;

- (void)uploadImage:(UIImage*)image params:(NSDictionary *)params completionHandler:(void(^)(NSString *imgUrl, NSError* error))handler;

@end
