//
//  BSPlayerSelectViewController.h
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/15.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BSPlayerSelectViewControllerDelegate <NSObject>

-(void)addNewPlayer:(NSString*)name;
-(void)cancel;
-(void)loadPlayer:(NSString*)name;

@end

@interface BSPlayerSelectViewController : UIViewController

@property (nonatomic, assign) id<BSPlayerSelectViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField* textField;

-(IBAction)addNewPlayer:(id)sender;
-(IBAction)cancel:(id)sender;
-(IBAction)loadPlayer:(id)sender;

@end
