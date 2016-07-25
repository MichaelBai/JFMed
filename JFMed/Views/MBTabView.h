//
//  MBTabView.h
//  JFMed
//
//  Created by Michael on 7/24/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBTabView;

@protocol MBTabViewButtonClickDelegate <NSObject>

- (void)MBTabView:(MBTabView *)view didClickButtonAtIndex:(NSInteger)idx;

@end

@interface MBTabView : UIScrollView

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL isThinnerStyle; // 在最前沿的详情页面使用的样式
@property (nonatomic, weak) id <MBTabViewButtonClickDelegate> btnClickDelegate;

@end
