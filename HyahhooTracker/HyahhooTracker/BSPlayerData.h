//
//  BSPlayerData.h
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BSPlayerData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * handCount;
@property (nonatomic, retain) NSNumber * pfCallCount;
@property (nonatomic, retain) NSNumber * pfRaiseCount;
@property (nonatomic, retain) NSNumber * pfReRaiseCount;
@property (nonatomic, retain) NSNumber * pfFoldCount;
@property (nonatomic, retain) NSNumber * flopCBChance;
@property (nonatomic, retain) NSNumber * flopCBCount;
@property (nonatomic, retain) NSNumber * flopFoldtoCB;
@property (nonatomic, retain) NSNumber * flopCalltoCB;
@property (nonatomic, retain) NSNumber * flopRaisetoCB;
@property (nonatomic, retain) NSString * memo;

@end
