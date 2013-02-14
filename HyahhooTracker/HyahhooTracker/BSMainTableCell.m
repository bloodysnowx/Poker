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

-(void)awakeFromNib
{
    [super awakeFromNib];
    // [self.SeatLabel = ]
}

+(BSMainTableCell*)create
{
    NSArray* ary = [[NSBundle mainBundle] loadNibNamed:@"BSMainTableCell" owner:nil options:nil];
    BSMainTableCell* cell = ary[0];
    return cell;
}

+(NSString*)reuseIdentifier {
    return CELL_IDENTIFIER;
}

-(IBAction) pushedActionControl:(UISegmentedControl*)sender
{
    NSLog(@"value changed");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    // [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

-(void)setSeatNum:(NSInteger)num
{
    self.SeatLabel.text = self.SeatLabel2.text = [NSString stringWithFormat:@"%02d", num];
}
@end
