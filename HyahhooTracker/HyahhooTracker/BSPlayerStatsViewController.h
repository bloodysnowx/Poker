//
//  BSPlayerStatsViewController.h
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/17.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSMainTableCell.h"

@class BSMainTableCell;

@protocol BSPlayerStatsViewControllerDelegate <NSObject>

-(void)replaceMemo:(NSString*)memo sender:(BSMainTableCell*)sender;
-(void)cancelMemo:(BSMainTableCell *)sender;

@end

@interface BSPlayerStatsViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, assign) id<BSPlayerStatsViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UILabel* nameLabel;
@property (nonatomic, assign) BSMainTableCell* sender;

- (id)initWithNibName:(NSString*)nibNameOrNil sender:(BSMainTableCell*)sender delegate:(id<BSPlayerStatsViewControllerDelegate>)delegate;
-(IBAction)replaceMemo:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)closeKeyboard:(id)sender;

@end
