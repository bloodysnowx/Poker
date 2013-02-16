//
//  BSMainTableCell.m
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/07.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSMainTableCell.h"


@implementation BSMainTableCell

static NSString * const CELL_IDENTIFIER = @"BSMainTableCell";

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(BSMainTableCell*)create
{
    NSArray* ary = [[NSBundle mainBundle] loadNibNamed:@"BSMainTableCell" owner:nil options:nil];
    BSMainTableCell* cell = ary[0];
    cell.isEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setIsEnabled:(BOOL)isEnabled
{
    _isEnabled = isEnabled;
    self.HideView.alpha = isEnabled ? 0 : 0.5;
}

+(NSString*)reuseIdentifier {
    return CELL_IDENTIFIER;
}

-(void)setSeatNum:(NSInteger)num
{
    NSString* title = [NSString stringWithFormat:@"%02d", num];
    [self.SeatButton setTitle:title forState:UIControlStateNormal];
    [self.SeatButton2 setTitle:title forState:UIControlStateNormal];
}

-(IBAction)touchSeat:(id)sender
{
    self.isEnabled = !self.isEnabled;
    if(self.isEnabled == YES && [self.NameButton.titleLabel.text length] == 0)
        [self touchName:sender];
}

-(IBAction)touchName:(id)sender
{
    [self.delegate touchName:self];
}

-(void)reset
{
    [self.NameButton setTitle:@"" forState:UIControlStateNormal];
    [self.PFRButton setTitle:@"" forState:UIControlStateNormal];
    [self.VPButton setTitle:@"" forState:UIControlStateNormal];
    [self.ReraiseButton setTitle:@"" forState:UIControlStateNormal];
    self.HandLabel.text = @"";
}

-(void)reloadData
{
    [self.NameButton setTitle:self.data.name forState:UIControlStateNormal];
    if([self.data.handCount integerValue] == 0)
    {
        [self reset];
        return;
    }
    [self.PFRButton setTitle:[NSString stringWithFormat:@"%03d", [self.data.pfRaiseCount integerValue] * 100 / [self.data.handCount integerValue]] forState:UIControlStateNormal];
    [self.VPButton setTitle:[NSString stringWithFormat:@"%03d", [self.data.pfCallCount integerValue] * 100 / [self.data.handCount integerValue]] forState:UIControlStateNormal];
    [self.ReraiseButton setTitle:[NSString stringWithFormat:@"%03d", [self.data.pfReRaiseCount integerValue] * 100 / [self.data.handCount integerValue]] forState:UIControlStateNormal];
    self.HandLabel.text = [NSString stringWithFormat:@"%03d", [self.data.handCount integerValue]];
}

-(IBAction)showDeleteAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:@"削除してもよろしいですか？" delegate:self cancelButtonTitle:@"いいえ" otherButtonTitles:@"はい", nil];
    [alert show];
}

-(IBAction)memo
{
    [self.delegate memo:self];
}

-(void)deleteData
{
    [self.delegate deleteData:self];
    [self reset];
}

-(IBAction)showHandRange:(UIButton*)sender
{
    int percent = [sender.titleLabel.text intValue];
    NSLog(@"%d", percent);
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) [self deleteData];
}
@end
