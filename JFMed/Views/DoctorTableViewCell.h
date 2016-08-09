//
//  DoctorTableViewCell.h
//  JFMed
//
//  Created by Michael on 7/25/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Doctor;

@interface DoctorTableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isViewMode;

+ (CGFloat)CellHeight;
- (void)setDataWithDoctor:(Doctor *)doctor;

@end
