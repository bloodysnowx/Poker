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
    for(int i = 0; i < 10; ++i)
    {
        NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
        BSMainTableCell* cell = [self.tableView cellForRowAtIndexPath:index];
        [cell setSeatNum:i + 1];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    BSMainTableCell* cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
    [cell setSeatNum:destinationIndexPath.row + 1];
    if(sourceIndexPath.row < destinationIndexPath.row)
    {
        for(int i = sourceIndexPath.row + 1; i <= destinationIndexPath.row; ++i)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            cell = [self.tableView cellForRowAtIndexPath:index];
            [cell setSeatNum:i];
        }
    }
    else if(sourceIndexPath.row > destinationIndexPath.row)
    {
        for(int i = destinationIndexPath.row; i < sourceIndexPath.row; ++i)
        {
            NSIndexPath* index = [NSIndexPath indexPathForItem:i inSection:0];
            cell = [self.tableView cellForRowAtIndexPath:index];
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

#pragma mark BSMainTableCellDelegat

-(void)touchName:(BSMainTableCell *)sender
{
    BSPlayerSelectViewController* viewController = [[BSPlayerSelectViewController alloc] initWithNibName:@"BSPlayerSelectViewController" sender:sender delegate:self];
    [self presentModalViewController:viewController animated:YES];
}

#pragma mark BSPlayerSelectViewControllerDelegate

-(void)exitPlayerSelectView:(BSMainTableCell *)sender;
{
    [self dismissModalViewControllerAnimated:YES];
    if([sender.NameButton.titleLabel.text length] < 1) [sender setIsEnabled:NO];
}

-(void)addNewPlayer:(NSString*)name sender:(BSMainTableCell *)sender
{
    sender.data = [NSEntityDescription insertNewObjectForEntityForName:@"BSPlayerData" inManagedObjectContext:self.managedObjectContext];
    sender.data.name = name;
    [sender reloadData];
    [self exitPlayerSelectView:sender];
}
-(void)cancel:(BSMainTableCell *)sender
{
    [self exitPlayerSelectView:sender];
}
-(void)loadPlayer:(NSString*)name sender:(BSMainTableCell *)sender
{
    
}

@end
