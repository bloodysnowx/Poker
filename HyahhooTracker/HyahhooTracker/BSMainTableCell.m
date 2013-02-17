//
//  BSMainTableCell.m
//  HyahhooTracker
//
//  Created by Atsushi Iwasa on 2013/02/07.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSMainTableCell.h"
#import "HandRangeCalculator.h"

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
    [self.PFAFLabel setText:@""];
    self.HandLabel.text = @"";
}

-(void)reloadData
{
    if([self.data.handCount integerValue] == 0)
    {
        [self reset];
        [self.NameButton setTitle:self.data.name forState:UIControlStateNormal];
        return;
    }
    [self.NameButton setTitle:self.data.name forState:UIControlStateNormal];
    [self.PFRButton setTitle:[NSString stringWithFormat:@"%03d", [self.data getPFR]] forState:UIControlStateNormal];
    [self.VPButton setTitle:[NSString stringWithFormat:@"%03d", [self.data getPFR]] forState:UIControlStateNormal];
    [self.ReraiseButton setTitle:[NSString stringWithFormat:@"%03d", [self.data getPF3B]] forState:UIControlStateNormal];
    [self.PFAFLabel setText:[NSString stringWithFormat:@"%2.1f", [self.data getPFAF]]];
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
    NSString* range = [HandRangeCalculator getHandRange:&percent];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"上位%d%%ハンドレンジ", percent] message:range delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES", nil];
    [alert show];
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) [self deleteData];
}
@end
