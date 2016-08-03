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
#define NETWORK                         [NetworkCenter sharedCenter]

//十六色值
#define HEXColor(c)                     [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b)                 [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a)              [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define COLOR_THEME           HEXColor(0x2dd2cc)
#define COLOR_LINE            HEXColor(0xeaeaea)
#define COLOR_TITLE           HEXColor(0x222222)
#define COLOR_NOTICE          HEXColor(0x999999)
#define COLOR_NAV             HEXColor(0x555d71)
#define COLOR_BACKGROUND      HEXColor(0xf2f5fc)

#define FONT_(xx)                       [UIFont systemFontOfSize:xx]
#define FONT_BOLD_(xx)                  [UIFont boldSystemFontOfSize:xx]

#define SCREEN_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define SCREEN_SCALE            [[UIScreen mainScreen] scale]

#define NAV_HEIGHT 64

#define apiHost                      @"http://www.meixinger.com/"

#endif /* Const_h */
