//
//  BSPlayerData.m
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSPlayerData.h"


@implementation BSPlayerData

@dynamic name;
@dynamic handCount;
@dynamic pfCallCount;
@dynamic pfRaiseCount;
@dynamic pfReRaiseCount;
@dynamic pfFoldCount;
@dynamic flopCBChance;
@dynamic flopCBCount;
@dynamic flopFoldtoCB;
@dynamic flopCalltoCB;
@dynamic flopRaisetoCB;
@dynamic memo;

-(int)getVPIP
{
    return [self.pfCallCount integerValue] * 100 / [self.handCount integerValue];
}

-(int)getPFR
{
    return [self.pfRaiseCount integerValue] * 100 / [self.handCount integerValue];
}
-(int)getPF3B
{
    return [self.pfReRaiseCount integerValue] * 100 / [self.handCount integerValue];
}
-(float)getPFAF
{
    float result = 9.9;
    int callCount = [self.pfCallCount intValue] - [self.pfRaiseCount intValue];
    if(callCount > 0)
    {
        result = MIN(result, [self.pfRaiseCount floatValue] / (float)callCount);
    }
    return result;
}
-(int)getCB
{
    int result = 0;
    if([self.flopCBChance intValue] > 0)
        result = [self.flopCBCount intValue] * 100 / [self.flopCBChance intValue];
    return result;
}
-(int)getFoldToCB
{
    int result = 0;
    int count = ([self.flopFoldtoCB intValue] + [self.flopCalltoCB intValue]);
    if(count > 0)
        result = [self.flopFoldtoCB intValue] * 100 / count;
    return result;
}
-(float)getFlopAF
{
    return 0.0;
}

@end
