//
//  HandRangeCalculator.m
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/17.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "HandRangeCalculator.h"

@implementation HandRangeCalculator

static const int PERCENTS[] = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
static const char* RANGES[] = { "88+,A9s+,KTs+,QTs+,AJo+,KQo",
    "66+,A4s+,K8s+,Q9s+,J9s+,T9s,A9o+,KTo+,QTo+,JTo",
    "55+,A2s+,K5s+,Q7s+,J8s+,T8s+,98s,A7o+,A5o,K9o+,Q9o+,J9o+,T9o",
    "44+,A2s+,K2s+,Q4s+,J7s+,T7s+,97s+,87s,A3o+,K7o+,Q8o+,J8o+,T9o",
    "33+,A2s+,K2s+,Q2s+,J4s+,T6s+,96s+,86s+,76s,65s,A2o+,K5o+,Q7o+,J7o+,T8o+,98o",
    "22+,A2s+,K2s+,Q2s+,J2s+,T3s+,95s+,85s+,75s+,64s+,54s,A2o+,K3o+,Q5o+,J7o+,T7o+,97o+,87o",
    "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,93s+,84s+,74s+,63s+,53s+,43s,A2o+,K2o+,Q3o+,J5o+,T6o+,96o+,86o+,76o",
    "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,92s+,82s+,73s+,62s+,52s+,43s,A2o+,K2o+,Q2o+,J3o+,T5o+,95o+,85o+,75o+,65o,54o",
    "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,92s+,82s+,72s+,62s+,52s+,42s+,32s,A2o+,K2o+,Q2o+,J2o+,T2o+,93o+,84o+,74o+,64o+,53o+",
    "random",};

+(NSString*)getHandRange:(int*)percent
{
    NSString* range = @"";
    for(int i = 0; i < sizeof(PERCENTS) / sizeof(PERCENTS[0]); ++i)
    {
        if(*percent <= PERCENTS[i])
        {
            *percent = PERCENTS[i];
            range = [NSString stringWithCString:RANGES[i] encoding:NSASCIIStringEncoding];
            break;
        }
    }
    return range;
}

@end
