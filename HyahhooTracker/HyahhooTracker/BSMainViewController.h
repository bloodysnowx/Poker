//
//  BSMainViewController.h
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/06.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSMainTableCell.h"

@interface BSMainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, BSMainTableCellDelegate>

@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet BSMainTableCell* cell;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, assign) BOOL isPreFlop;

-(IBAction) moveToFlop;
-(IBAction) moveToPreF;
-(IBAction) toggleEdit;

@end
