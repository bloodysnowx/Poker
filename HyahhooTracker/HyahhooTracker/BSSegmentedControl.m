//
//  BSSegmentedControl.m
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/09.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSSegmentedControl.h"

@interface BSSegmentedControl()
{
    // NSInteger old_selected_index;
}
@end

@implementation BSSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // old_selected_index = -1;
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    // if(old_selected_index == self.selectedSegmentIndex)
    // {
    // self.selectedSegmentIndex = -1;
    // NSLog(@"value reseted");
    // [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    // }
    
    // old_selected_index = self.selectedSegmentIndex;
}

@end
