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

-(void)reloadData
{
    [self.NameButton setTitle:self.data.name forState:UIControlStateNormal];
    if([self.data.handCount integerValue] == 0) return;
    self.PFRLabel.text = [NSString stringWithFormat:@"%03d", ([self.data.pfRaiseCount integerValue] + [self.data.pfReRaiseCount integerValue]) * 100 / [self.data.handCount integerValue]];
    self.VPLabel.text = [NSString stringWithFormat:@"%03d", ([self.data.pfRaiseCount integerValue] + [self.data.pfCallCount integerValue] + [self.data.pfReRaiseCount integerValue]) * 100 / [self.data.handCount integerValue]];
    self.ReraiseLabel.text = [NSString stringWithFormat:@"%03d", [self.data.pfReRaiseCount integerValue] * 100 / [self.data.handCount integerValue]];
}
@end
