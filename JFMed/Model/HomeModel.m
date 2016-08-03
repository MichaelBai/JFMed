//
//  HomeModel.m
//  JFMed
//
//  Created by Michael on 8/1/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeBanner

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

@end

@implementation HomeNews

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

@end

@implementation HomeDoctor

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return [NSDictionary mtl_identityPropertyMapWithModel:[self class]];
}

@end
