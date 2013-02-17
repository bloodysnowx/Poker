//
//  NSNumber+Increment.m
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/17.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "NSNumber+Increment.h"

@implementation NSNumber (Increment)

-(NSNumber*)increment
{
    return [NSNumber numberWithInteger:[self integerValue] + 1];
}

@end
