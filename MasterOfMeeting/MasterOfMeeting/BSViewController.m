//
//  BSViewController.m
//  MasterOfMeeting
//
//  Created by Atsushi Iwasa on 2013/02/13.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface BSViewController ()
{
    AVAudioPlayer* player;
}

@end

@implementation BSViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* filePath = [mainBundle pathForResource:@"01_OP" ofType:@"mp3"];
    NSURL* fileUrl = [NSURL fileURLWithPath:filePath];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    [player prepareToPlay];
    [player play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
