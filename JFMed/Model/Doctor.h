//
//  Doctor.h
//  JFMed
//
//  Created by Michael on 7/31/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Doctor : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hospital;
@property (nonatomic, copy) NSString *doctor_id;
@property (nonatomic, copy) NSString *consultation_times;

@end
