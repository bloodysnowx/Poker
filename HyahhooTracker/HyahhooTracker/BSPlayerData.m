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

@end
