//
//  BSMovingImageView.m
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSMovingImageView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation BSMovingImageView

static const int ANIMATION_DURATION = 15;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)calcVisibleArea
{
    CGImageRef imageRef = [self.image CGImage];
    float imgW = (float)CGImageGetWidth(imageRef);
    float imgH = (float)CGImageGetHeight(imageRef);
    float viewW = self.frame.size.width;
    float viewH = self.frame.size.height;
    
    float aspect;
    CGRect resizedRect;
    
    if (viewW/imgW < viewH/imgH) {
        aspect = (viewW/viewH * imgH/imgW);
        resizedRect = CGRectMake(0, 0, viewW / aspect, viewH);
        self.visibleArea = CGSizeMake(1.0, aspect);
    } else {
        aspect = (viewH/viewW * imgW/imgH);
        resizedRect = CGRectMake(0, 0, viewW, viewH / aspect);
        self.visibleArea = CGSizeMake(aspect, 1.0);
    }
}

- (void)startMove
{
    [self calcVisibleArea];
    CGRect toRect = CGRectMake(1.0 - self.visibleArea.height, 1.0 - self.visibleArea.width, 1, 1);
    NSValue* center      = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)]; // 中央
    NSValue* bottomRight = [NSValue valueWithCGRect:CGRectMake( toRect.origin.x / 2.0,  toRect.origin.y / 2.0, 1, 1)]; // 左端 or 上端
    NSValue* topLeft     = [NSValue valueWithCGRect:CGRectMake(-toRect.origin.x / 2.0, -toRect.origin.y / 2.0, 1, 1)]; // 右端 or 下端
    
    CAKeyframeAnimation* swipeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contentsRect"];
    swipeAnimation.duration = ANIMATION_DURATION / MIN(self.visibleArea.width, self.visibleArea.height);
    // swipeAnimation.repeatCount = FLT_MAX;
    swipeAnimation.repeatCount = FLT_MAX;
    swipeAnimation.values = [[NSArray alloc] initWithObjects:
                             center,
                             topLeft,
                             center,
                             bottomRight,
                             center,
                             nil];
    
    swipeAnimation.delegate = self;
    swipeAnimation.removedOnCompletion = YES;
    
    [self.layer addAnimation:swipeAnimation forKey:@"contentsRect"];
}

@end
