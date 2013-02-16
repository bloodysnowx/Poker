//
//  BSPlayerSelectViewController.h
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/15.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSMainTableCell.h"

@protocol BSPlayerSelectViewControllerDelegate <NSObject>

-(void)addNewPlayer:(NSString*)name sender:(BSMainTableCell*)sender;
-(void)cancel:(BSMainTableCell *)sender;
-(void)loadPlayer:(NSString*)name sender:(BSMainTableCell *)sender;

@end

@interface BSPlayerSelectViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, assign) id<BSPlayerSelectViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField* textField;
@property (nonatomic, assign) BSMainTableCell* sender;

- (id)initWithNibName:(NSString*)nibNameOrNil sender:(BSMainTableCell*)sender delegate:(id<BSPlayerSelectViewControllerDelegate>)delegate;

-(IBAction)addNewPlayer:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)loadPlayer:(id)sender;

@end
