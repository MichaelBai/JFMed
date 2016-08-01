//
//  Doctor.m
//  JFMed
//
//  Created by Michael on 7/31/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "Doctor.h"

@implementation Doctor

/*
 "avatar":"http://money.gucheng.com/UploadFiles_6503/201508/2015082523214635.jpg",
 "name":"赵一鸣",
 "title":"主任医师",
 "hospital":"北京协和医院",
 "doctor_id":"123456",
 "consultation_times":"149"
 */

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
//    return @{
//             @"avatar": @"avatar",
//             @"HTMLURL": @"html_url",
//             @"number": @"number",
//             @"state": @"state",
//             @"reporterLogin": @"user.login",
//             @"assignee": @"assignee",
//             @"updatedAt": @"updated_at"
//             };
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue error:(NSError **)error {
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        
    }
    return self;
}

@end
