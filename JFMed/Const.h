//
//  Const.h
//  JFMed
//
//  Created by Michael on 7/20/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#ifndef Const_h
#define Const_h

#define kAppDelegate                    ((AppDelegate*)[[UIApplication sharedApplication] delegate])

//十六色值
#define HEXColor(c)                     [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//NavBar背景色
#define COLOR_NAV                       [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1.000]

#define FONT_(xx)                       [UIFont systemFontOfSize:xx]
#define FONT_BOLD_(xx)                  [UIFont boldSystemFontOfSize:xx]

#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_SCALE            [[UIScreen mainScreen] scale]

#define NAV_HEIGHT 64

#endif /* Const_h */
