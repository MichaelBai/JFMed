//
//  NewsTableViewCell.h
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeNews;

@interface NewsTableViewCell : UITableViewCell

+ (CGFloat)CellHeight;
- (void)setDataWithNews:(HomeNews *)news;

@end
