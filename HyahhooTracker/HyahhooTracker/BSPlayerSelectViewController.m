//
//  BSPlayerSelectViewController.m
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/15.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSPlayerSelectViewController.h"

@interface BSPlayerSelectViewController ()

@end

@implementation BSPlayerSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString*)nibNameOrNil sender:(BSMainTableCell*)sender delegate:(id<BSPlayerSelectViewControllerDelegate>)delegate
{
    self = [self initWithNibName:nibNameOrNil bundle:nil];
    if(self)
    {
        self.delegate = delegate;
        self.sender = sender;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.textField setText:self.sender.NameButton.titleLabel.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewPlayer:(id)sender
{
    if([self.textField.text length] < 1) return;
    [self.delegate addNewPlayer:self.textField.text sender:self.sender];
}
-(IBAction)cancel:(id)sender
{
    [self.delegate cancel:self.sender];
}
-(IBAction)loadPlayer:(id)sender
{
    [self.delegate loadPlayer:nil sender:self.sender];
}

#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
