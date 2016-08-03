//
//  NetworkCenter.m
//  JFMed
//
//  Created by Michael on 7/31/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "NetworkCenter.h"

#define kErrorUserInfoMsgKey            @"errorMsg"         // 错误Key
NSString * const kResponseDataJSONKey_Code                 = @"result";
NSString * const kResponseDataJSONKey_Data                 = @"data";
NSString * const kResponseDataJSONKey_Mesg                 = @"error_info";
NSString * const kResponseDataJSONKey_Page                 = @"page_temp";
NSString * const kResponseDataJSONKey_Count                = @"size_in_one_page";
NSString * const kResponseDataJSONKey_Total                = @"size_total";
NSInteger const kResponseErrorCode_NoError                 = 0;

@interface NetworkCenter ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *engine;

@end

@implementation NetworkCenter

+ (instancetype)sharedCenter
{
    static NetworkCenter *center;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[NetworkCenter alloc] init];
        [center setup];
    });
    return center;
}

- (void)setup
{
    self.engine = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:apiHost]];
    self.engine.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.engine.responseSerializer = [AFJSONResponseSerializer serializer];
//    self.engine.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
}

- (void)postWithApiPath:(NSString *)apiPath
          requestParams:(NSDictionary *)requestParams
                handler:(NetworkCompletionHandler)handler
{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", apiHost, apiPath];
    [self.engine POST:requestURL parameters:requestParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleGenerallResponse:responseObject handler:handler];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) {
            handler(nil, [self _wrapHTTPError:error], NO);
        }
    }];
}

- (void)getWithApiPath:(NSString *)apiPath
         requestParams:(NSDictionary *)requestParams
               handler:(NetworkCompletionHandler)handler
{
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", apiHost, apiPath];
    [self.engine GET:requestURL parameters:requestParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self handleGenerallResponse:responseObject handler:handler];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (handler) {
            handler(nil, [self _wrapHTTPError:error], NO);
        }
    }];
}

#pragma mark - Private Methods

- (void)handleGenerallResponse:(id)response
                       handler:(NetworkCompletionHandler)handler
{
    NSInteger code = [self _responseErrorCode:response];
    if (code == kResponseErrorCode_NoError) {
        id data = [response objectForKey:kResponseDataJSONKey_Data];
        
        BOOL updatePage = NO;
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSInteger page = [data[kResponseDataJSONKey_Page] integerValue];
            NSInteger count = [data[kResponseDataJSONKey_Count] integerValue];
            NSInteger total = [[data objectForKey:kResponseDataJSONKey_Total] integerValue];
            updatePage = total > page * count;
        }
        
        if (handler) {
            handler(data, nil, updatePage);
        }
    } else {
        NSError *error = [NSError errorWithDomain:@"ErrorDomain"
                                             code:code
                                         userInfo:@{kErrorUserInfoMsgKey:[response objectForKey:kResponseDataJSONKey_Mesg]}];
        if (handler) {
            handler(response, error, NO);
        }
    }
}

- (NSInteger)_responseErrorCode:(id)response
{
    if ([response isKindOfClass:[NSDictionary class]]) {
        NSInteger code = [response objectForKey:kResponseDataJSONKey_Code] ? [[response objectForKey:kResponseDataJSONKey_Code] integerValue] : NSIntegerMax;
        return code;
    }
    return NSIntegerMax;
}

- (NSError*)_wrapHTTPError:(NSError*)error
{
    NSMutableDictionary* userinfo = [error.userInfo mutableCopy];
    if ([[userinfo allKeys] containsObject:kErrorUserInfoMsgKey] == NO) {
        [userinfo setObject:@"网络连接出错，请检查网络" forKey:kErrorUserInfoMsgKey];
    }
    return [NSError errorWithDomain:error.domain code:error.code userInfo:userinfo];
}

@end
