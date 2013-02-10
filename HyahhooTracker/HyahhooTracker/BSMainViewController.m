//
//  BSMainViewController.m
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/06.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSMainViewController.h"
#import "BSMainTableCell.h"
#import "BSPlayerData.h"

@interface BSMainViewController ()
{
    NSArray* playerDatas;
}

@end

@implementation BSMainViewController

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
    // BSPlayerData* playerData = [NSEntityDescription insertNewObjectForEntityForName:@"BSPlayerData" inManagedObjectContext:self.managedObjectContext];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // [self.tableView registerNib:[UINib nibWithNibName: bundle:nil] forCellReuseIdentifier:[BSMainTableCell reuseIdentifier]];
    self.scrollView.contentSize = self.tableView.frame.size;
    NSLog(@"width = %f, height = %f", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"BSPlayerData"];
    playerDatas = [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSMainTableCell* cell = [self.tableView dequeueReusableCellWithIdentifier:[BSMainTableCell reuseIdentifier]];
    if (!cell) {
        cell = [BSMainTableCell create];
    }
    // BSMainTableCell* cell = [self.tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Num Name  Action     VP PF 3B AF";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

#pragma mark UITableViewDelegate

-(IBAction) moveToFlop
{
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

-(IBAction) moveToPreF
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
