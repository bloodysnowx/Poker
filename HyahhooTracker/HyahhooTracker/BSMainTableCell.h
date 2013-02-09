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
@property (nonatomic, retain) IBOutlet UILabel* NameLabel;
@property (nonatomic, retain) IBOutlet UISegmentedControl* actionControl;
// @property (nonatomic, retain) IBOutlet
+(BSMainTableCell*)create;
+(NSString*)reuseIdentifier;
@end
