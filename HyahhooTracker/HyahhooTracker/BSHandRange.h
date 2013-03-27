//
//  BSHandRange.h
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/03/17.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSHandRange : NSObject

@property (nonatomic, assign) int percent;
@property (nonatomic, retain) NSString* range;

+(NSString*)getHandRange:(int*)percent;

@end
