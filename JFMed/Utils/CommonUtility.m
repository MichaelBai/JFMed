//
//  CommonUtility.m
//  JFMed
//
//  Created by Michael on 7/26/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "CommonUtility.h"

@implementation CommonUtility

+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string
                                                   lineSpace:(CGFloat) space
                                                        font:(UIFont *)font
                                                   alignment:(NSTextAlignment)alignment
{
    if (!string) {
        string = @"";
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [paragraphStyle setAlignment:alignment];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    return attributedString;
}

+ (UIImage *)stretchImageNamed:(NSString *)imageName
{
    UIImage *originalImage = [UIImage imageNamed:imageName];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 25, 0, 25);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    return stretchableImage;
}

@end
