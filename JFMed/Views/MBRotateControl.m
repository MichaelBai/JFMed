//
//  MBRotateControl.m
//  JFMed
//
//  Created by Michael on 7/22/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "MBRotateControl.h"

const CGFloat kInvalidDeltaAngle = 1024;

@interface MBRotateControl ()

@property (nonatomic, strong) UIImageView *container;
@property (nonatomic, strong) UIImageView *yellowLine;
@property (nonatomic, strong) UIImageView *knob;
@property (nonatomic, assign) CGRect knobRect;
@property (nonatomic, assign) CGAffineTransform startTransform;
@property (nonatomic, assign) CGFloat deltaAngle;

@end

@implementation MBRotateControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.container = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.container];
        self.yellowLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 3)];
        self.yellowLine.backgroundColor = [UIColor yellowColor];
        self.yellowLine.center = self.container.center;
        [self.container addSubview:self.yellowLine];
        self.knob = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.knob.backgroundColor = [UIColor darkGrayColor];
        self.knob.center = CGPointMake(self.container.center.x + self.yellowLine.frame.size.width/2, self.container.center.y);
        self.knobRect = CGRectMake(self.knob.center.x-10, self.knob.center.y-10, 20, 20);
        [self.container addSubview:self.knob];
    }
    return self;
}

// https://www.raywenderlich.com/9864/how-to-create-a-rotating-wheel-control-with-uikit
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    // 1 - Get touch position
    CGPoint touchPoint = [touch locationInView:self];
    
    CGRect convertedFrame = [self convertRect:self.knob.frame fromView:self.container];
    if (CGRectContainsPoint(convertedFrame, touchPoint)) {
        NSLog(@"%@", NSStringFromCGPoint(touchPoint));
        
        // 2 - Calculate distance from center
        float dx = touchPoint.x - self.container.center.x;
        float dy = touchPoint.y - self.container.center.y;
        // 3 - Calculate arctangent value
        self.deltaAngle = atan2(dy,dx);
        // 4 - Save current transform
        self.startTransform = self.container.transform;
    } else {
        self.deltaAngle = kInvalidDeltaAngle;
    }
    
    
    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    if (self.deltaAngle == kInvalidDeltaAngle) {
        return NO;
    }
    CGPoint touchPoint = [touch locationInView:self];
    float dx = touchPoint.x - self.container.center.x;
    float dy = touchPoint.y - self.container.center.y;
    float ang = atan2(dy,dx);
    float angleDifference = self.deltaAngle - ang;
//    NSLog(@"diff %.2f", angleDifference * 180 / M_PI);
    self.container.transform = CGAffineTransformRotate(self.startTransform, -angleDifference);
    float currentAngle = atan2(self.container.transform.b, self.container.transform.a);
    NSLog(@"current %.2f", currentAngle * 180 / M_PI);
    return YES;
}

@end
