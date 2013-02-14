//
//  BSMainTableCell.h
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/07.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMainTableCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel* SeatLabel;
@property (nonatomic, retain) IBOutlet UILabel* SeatLabel2;
@property (nonatomic, retain) IBOutlet UILabel* NameLabel;
@property (nonatomic, retain) IBOutlet UILabel* NameLabel2;
@property (nonatomic, retain) IBOutlet UISegmentedControl* actionControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl* actionControl2;
@property (nonatomic, retain) IBOutlet UILabel* PFLabel;
@property (nonatomic, retain) IBOutlet UILabel* VPLabel;
@property (nonatomic, retain) IBOutlet UILabel* ReraiseLabel;
@property (nonatomic, retain) IBOutlet UILabel* AFLabel;

// @property (nonatomic, retain) IBOutlet
+(BSMainTableCell*)create;
+(NSString*)reuseIdentifier;
-(IBAction) pushedActionControl:(UISegmentedControl*)sender;
-(void)setSeatNum:(NSInteger)num;

@end
