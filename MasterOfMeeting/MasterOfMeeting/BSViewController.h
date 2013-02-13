//
//  BSViewController.h
//  MasterOfMeeting
//
//  Created by Atsushi Iwasa on 2013/02/13.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSViewController : UIViewController<AVAudioPlayerDelegate>

-(IBAction)noButtonPushed:(id)sender;
-(IBAction)seyaButtonPushed:(id)sender;
-(IBAction)repeatButtonPushed:(id)sender;

@end
