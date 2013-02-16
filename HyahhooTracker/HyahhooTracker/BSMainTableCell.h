//
//  BSMainTableCell.h
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/07.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSPlayerData.h"
#import "BSPlayerStatsViewController.h"

@class BSMainTableCell;

@protocol BSMainTableCellDelegate <UIActionSheetDelegate, UIAlertViewDelegate>

-(void)touchName:(BSMainTableCell*)sender;
-(void)deleteData:(BSMainTableCell*)sender;
-(void)memo:(BSMainTableCell*)sender;

@end

@interface BSMainTableCell : UITableViewCell
{
    
}

@property (nonatomic, retain) IBOutlet UIButton* SeatButton;
@property (nonatomic, retain) IBOutlet UIButton* SeatButton2;
@property (nonatomic, retain) IBOutlet UIButton* NameButton;
@property (nonatomic, retain) IBOutlet UISegmentedControl* actionControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl* actionControl2;
@property (nonatomic, retain) IBOutlet UILabel* PFRLabel;
@property (nonatomic, retain) IBOutlet UILabel* VPLabel;
@property (nonatomic, retain) IBOutlet UILabel* ReraiseLabel;
@property (nonatomic, retain) IBOutlet UILabel* PFAFLabel;
@property (nonatomic, retain) IBOutlet UILabel* HandLabel;
@property (nonatomic, retain) IBOutlet UILabel* CBLabel;
@property (nonatomic, retain) IBOutlet UILabel* CBFLabel;
@property (nonatomic, retain) IBOutlet UILabel* FlopAFLabel;
@property (nonatomic, retain) IBOutlet UIView* HideView;

@property (nonatomic, retain) BSPlayerData* data;

-(IBAction)touchSeat:(id)sender;
-(IBAction)touchName:(id)sender;
-(IBAction)delete;

@property (nonatomic, assign) BOOL isEnabled;
@property (nonatomic, assign) id<BSMainTableCellDelegate> delegate;

+(BSMainTableCell*)create;
+(NSString*)reuseIdentifier;
-(void)setSeatNum:(NSInteger)num;
-(void)reloadData;


@end
