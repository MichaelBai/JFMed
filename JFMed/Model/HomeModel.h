//
//  HomeModel.h
//  JFMed
//
//  Created by Michael on 8/1/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HomeBanner : MTLModel

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;

@end

@interface HomeNews : MTLModel

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, assign) NSInteger heart_count;
@property (nonatomic, assign) NSInteger is_like;
@property (nonatomic, assign) NSInteger is_heart;

@end

@interface HomeDoctor : MTLModel

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *doctor_id;

@end
