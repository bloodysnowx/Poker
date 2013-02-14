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
        self.isPreFlop = YES;
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
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height);
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
    [cell setSeatNum:indexPath.row + 1];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray* ary = [[NSBundle mainBundle] loadNibNamed:@"BSMainTableHeader" owner:nil options:nil];
    UIView* view = ary[0];
    return view;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellAccessoryNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark ViewEvent
   
-(IBAction) moveToFlop
{
    self.isPreFlop = NO;
    [self.tableView setEditing:NO];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 640, self.tableView.frame.size.height);
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

-(IBAction) moveToPreF
{
    self.isPreFlop = YES;
    [self.tableView setEditing:NO];
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

-(IBAction) toggleEdit
{
    if(self.isPreFlop) self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height);
    [self.tableView setEditing:!self.tableView.isEditing];
}

@end
