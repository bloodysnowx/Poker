//
//  BSPlayerStatsViewController.m
//  HyahhooTracker
//
//  Created by 岩佐 淳史 on 13/02/17.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSPlayerStatsViewController.h"

@interface BSPlayerStatsViewController ()

@end

@implementation BSPlayerStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.nameLabel.text = self.sender.data.name;
    [self.textView setText:self.sender.data.memo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString*)nibNameOrNil sender:(BSMainTableCell*)sender delegate:(id<BSPlayerStatsViewControllerDelegate>)delegate
{
    self = [self initWithNibName:nibNameOrNil bundle:nil];
    if(self)
    {
        self.delegate = delegate;
        self.sender = sender;
    }
    return self;
}

-(IBAction)replaceMemo:(id)sender
{
    [self.delegate replaceMemo:self.textView.text sender:self.sender];
}

-(IBAction)cancel:(id)sender
{
    [self.delegate cancelMemo:self.sender];
}

-(IBAction)closeKeyboard:(id)sender
{
    [self.textView resignFirstResponder];
}

@end
