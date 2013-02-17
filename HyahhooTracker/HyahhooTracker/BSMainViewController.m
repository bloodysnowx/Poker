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
#import "NSNumber+Increment.h"

static const int SEAT_NUM = 10;
#define ENTITY_NAME @"BSPlayerData"
#define ENTITY_PKEY @"name"

@interface BSMainViewController ()
{
    NSMutableArray* playerNames;
    NSFetchRequest *fetchRequest;
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
    [super viewDidLoad];
    self.scrollView.contentSize = self.tableView.frame.size;
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 320, self.tableView.frame.size.height);
    fetchRequest = [self createRequest];
    NSArray* playerDatas = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    playerNames = [[NSMutableArray alloc] initWithCapacity:[playerDatas count]];
    for(BSPlayerData* data in playerDatas)
        [playerNames addObject:data.name];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // [self resetSeatNums];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return SEAT_NUM;
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
    cell.delegate = self;
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

- (void)resetSeatNums
{
    for(int i = 0; i < SEAT_NUM; ++i)
    {
        NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
        BSMainTableCell* cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:index];
        [cell setSeatNum:i + 1];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    BSMainTableCell* cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:sourceIndexPath];
    [cell setSeatNum:destinationIndexPath.row + 1];
    if(sourceIndexPath.row < destinationIndexPath.row)
    {
        for(int i = sourceIndexPath.row + 1; i <= destinationIndexPath.row; ++i)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell setSeatNum:i];
        }
    }
    else if(sourceIndexPath.row > destinationIndexPath.row)
    {
        for(int i = destinationIndexPath.row; i < sourceIndexPath.row; ++i)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:index];
            [cell setSeatNum:i + 2];
        }
    }
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

-(void)highlightButton
{
    self.PFButton.highlighted = self.isPreFlop;
    self.FlopButton.highlighted = !self.isPreFlop;
    self.PFButton.enabled = !self.isPreFlop;
    self.FlopButton.enabled = self.isPreFlop;
}

-(void)setIsPreFlop:(BOOL)isPreFlop
{
    [self performSelector:@selector(highlightButton) withObject:nil afterDelay:0.0];
    _isPreFlop = isPreFlop;
}

-(IBAction) moveToFlop:(id)sender
{
    self.isPreFlop = NO;
    [self.tableView setEditing:NO];
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, 640, self.tableView.frame.size.height);
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

-(IBAction) moveToPreF:(id)sender
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

-(IBAction) nextHand
{
    for(int i = 0; i < SEAT_NUM; ++i)
    {
        NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
        BSMainTableCell* cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:index];
        if(cell.isEnabled)
        {
            switch (cell.actionControl.selectedSegmentIndex) {
                case 0:
                    cell.data.pfReRaiseCount = [cell.data.pfReRaiseCount increment];
                case 1:
                    cell.data.pfRaiseCount = [cell.data.pfRaiseCount increment];
                case 2:
                    cell.data.pfCallCount = [cell.data.pfCallCount increment];
                default:
                    cell.data.handCount = [cell.data.handCount increment];
                    break;
            }
            cell.actionControl.selectedSegmentIndex = 3;
            switch (cell.actionControl2.selectedSegmentIndex) {
                case 0:
                    cell.data.flopCBCount = [cell.data.flopCBCount increment];
                case 1:
                    cell.data.flopCBChance = [cell.data.flopCBChance increment];
                    break;
                case 2:
                    cell.data.flopCalltoCB = [cell.data.flopCalltoCB increment];
                    break;
                case 3:
                    cell.data.flopFoldtoCB = [cell.data.flopFoldtoCB increment];
                    break;
                default:
                    break;
            }
            cell.actionControl2.selectedSegmentIndex = 4;
            [cell reloadData];
        }
    }
}

#pragma mark BSMainTableCellDelegat

-(void)touchName:(BSMainTableCell *)sender
{
    BSPlayerSelectViewController* viewController = [[BSPlayerSelectViewController alloc] initWithNibName:@"BSPlayerSelectViewController" sender:sender delegate:self];
    [self presentModalViewController:viewController animated:YES];
}

-(void)deleteData:(BSMainTableCell*)sender
{
    [playerNames removeObject:sender.data.name];
    [self.managedObjectContext deleteObject:sender.data];
    sender.data = nil;
}

-(void)memo:(BSMainTableCell*)sender
{
    BSPlayerStatsViewController* viewController = [[BSPlayerStatsViewController alloc] initWithNibName:@"BSPlayerStatsViewController" sender:sender delegate:self];
    [self presentModalViewController:viewController animated:YES];
}

#pragma mark BSPlayerSelectViewControllerDelegate

-(void)exitPlayerSelectView:(BSMainTableCell *)sender;
{
    [self dismissModalViewControllerAnimated:YES];
    if([sender.NameButton.titleLabel.text length] < 1) [sender setIsEnabled:NO];
}

-(BOOL)isLoaded:(NSString*)name
{
    for(int i = 0; i < SEAT_NUM; ++i)
    {
        NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
        BSMainTableCell* cell = (BSMainTableCell*)[self.tableView cellForRowAtIndexPath:index];
        if([name isEqualToString:cell.NameButton.titleLabel.text]) return YES;
    }
    return NO;
}

-(void)addNewPlayer:(NSString*)name sender:(BSMainTableCell *)sender
{
    if([self isLoaded:name]) return;
    sender.data = [self selectByName:name];
    if(sender.data == nil) {
        sender.data = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:self.managedObjectContext];
        sender.data.name = name;
        [playerNames addObject:name];
    }
    [sender reloadData];
    [self exitPlayerSelectView:sender];
}

-(void)cancel:(BSMainTableCell *)sender
{
    [self exitPlayerSelectView:sender];
}

-(void)loadPlayer:(NSInteger)number sender:(BSMainTableCell *)sender
{
    NSString* name = playerNames[number];
    if([self isLoaded:name]) return;
    sender.data = [self selectByName:name];
    [sender reloadData];
    [self exitPlayerSelectView:sender];
}

#pragma mark core data

-(NSFetchRequest*)createRequest
{
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:ENTITY_NAME];
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:ENTITY_PKEY ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    return request;
}

-(BSPlayerData*)selectByName:(NSString*)name
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@", name];
    [fetchRequest setPredicate:pred];
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    if (![fetchedResultsController performFetch:nil]) return nil;
    NSArray *moArray = [fetchedResultsController fetchedObjects];
    if ([moArray count] == 0) return nil;
    BSPlayerData* playerData = moArray[0];
    return playerData;
}

#pragma mark UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [playerNames count];
}

-(NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return playerNames[row];
}

#pragma mark BSPlayerStatsViewControllerDelegate

-(void)exitPlayerStatsView:(BSMainTableCell *)sender;
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)replaceMemo:(NSString*)memo sender:(BSMainTableCell*)sender
{
    sender.data.memo = memo;
    [self exitPlayerStatsView:sender];
}

-(void)cancelMemo:(BSMainTableCell *)sender
{
    [self exitPlayerStatsView:sender];
}

#undef ENTITY_NAME

@end
