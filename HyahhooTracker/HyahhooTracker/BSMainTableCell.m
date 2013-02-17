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

static const int PERCENTS[] = { 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 };
static const char* RANGES[] = { "88+,A9s+,KTs+,QTs+,AJo+,KQo",
                                "66+,A4s+,K8s+,Q9s+,J9s+,T9s,A9o+,KTo+,QTo+,JTo",
                                "55+,A2s+,K5s+,Q7s+,J8s+,T8s+,98s,A7o+,A5o,K9o+,Q9o+,J9o+,T9o",
                                "44+,A2s+,K2s+,Q4s+,J7s+,T7s+,97s+,87s,A3o+,K7o+,Q8o+,J8o+,T9o",
                                "33+,A2s+,K2s+,Q2s+,J4s+,T6s+,96s+,86s+,76s,65s,A2o+,K5o+,Q7o+,J7o+,T8o+,98o",
                                "22+,A2s+,K2s+,Q2s+,J2s+,T3s+,95s+,85s+,75s+,64s+,54s,A2o+,K3o+,Q5o+,J7o+,T7o+,97o+,87o",
                                "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,93s+,84s+,74s+,63s+,53s+,43s,A2o+,K2o+,Q3o+,J5o+,T6o+,96o+,86o+,76o",
                                "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,92s+,82s+,73s+,62s+,52s+,43s,A2o+,K2o+,Q2o+,J3o+,T5o+,95o+,85o+,75o+,65o,54o",
                                "22+,A2s+,K2s+,Q2s+,J2s+,T2s+,92s+,82s+,72s+,62s+,52s+,42s+,32s,A2o+,K2o+,Q2o+,J2o+,T2o+,93o+,84o+,74o+,64o+,53o+",
                                "random",};

-(IBAction)showHandRange:(UIButton*)sender
{
    int percent = [sender.titleLabel.text intValue];
    NSString* range = nil;
    for(int i = 0; i < sizeof(PERCENTS) / sizeof(PERCENTS[0]); ++i)
    {
        if(percent <= PERCENTS[i])
        {
            percent = PERCENTS[i];
            range = [NSString stringWithCString:RANGES[i] encoding:NSASCIIStringEncoding];
            break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"上位%d%%ハンドレンジ", percent] message:range delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES", nil];
    [alert show];
}

#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1) [self deleteData];
}
@end
