//
//  UserInfo.h
//  JFMed
//
//  Created by Michael on 8/8/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nick_name;
@property (nonatomic, copy) NSString *born;
@property (nonatomic, copy) NSString *gender;

@end
