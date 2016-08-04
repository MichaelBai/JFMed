//
//  CommonUtility.h
//  JFMed
//
//  Created by Michael on 7/26/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtility : NSObject

/**
 *  可控制行间距的字符串
 *
 *  @param      string      文本内容
 *  @param      space       行间距
 *  @param      font        字体
 *  @param      alignment   对齐方式
 *  @return     AttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string
                                                   lineSpace:(CGFloat)space
                                                        font:(UIFont *)font
                                                   alignment:(NSTextAlignment)alignment;

+ (UIImage *)stretchImageNamed:(NSString *)imageName;

@end
