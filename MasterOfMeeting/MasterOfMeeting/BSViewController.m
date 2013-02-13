//
//  BSViewController.m
//  MasterOfMeeting
//
//  Created by Atsushi Iwasa on 2013/02/13.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSViewController.h"

@interface BSViewController ()
{
    AVAudioPlayer* player;
    NSMutableArray* fileURLs;
    int nowCount;
}

@end

@implementation BSViewController

static const char* const TIME_WARNING_MP3 = "20_ED";
static const char* const TIME_ENDED_MP3 = "20_ED";
static const int WARNING_TIME = 30;
static const int ENDING_TIME = 30;

- (void)playChar:(const char* const)path
{
    NSURL* fileURL = [self getURLfromBundleChar:path];
    [self play:fileURL];
}

- (void)play:(NSURL*)fileURL
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player prepareToPlay];
    [player play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    
}

- (NSURL*)getURLfromBundleChar:(const char* const)path
{
    NSString* str = [NSString stringWithCString:path encoding:NSASCIIStringEncoding];
    return [self getURLfromBundle:str];
}

- (NSURL*)getURLfromBundle:(NSString*)path
{
    NSBundle* mainBundle = [NSBundle mainBundle];
    NSString* filePath = [mainBundle pathForResource:path ofType:@"mp3"];
    return [NSURL fileURLWithPath:filePath];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    nowCount = 0;
	// Do any additional setup after loading the view, typically from a nib.
    NSArray* filePaths = [[NSArray alloc] initWithObjects:@"01_OP", @"20_ED", nil];
    fileURLs = [[NSMutableArray alloc] initWithCapacity:[filePaths count]];
    for(NSString* path in filePaths)
        [fileURLs addObject:[self getURLfromBundle:path]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPushed:(id)sender
{
    [self play:fileURLs[nowCount++]];
    [self performSelector:@selector(timeWarning) withObject:nil afterDelay:WARNING_TIME];
}

-(void)timeWarning
{
    [self playChar:TIME_WARNING_MP3];
    [self performSelector:@selector(timeEnded) withObject:nil afterDelay:ENDING_TIME];
}

-(void)timeEnded
{
    [self playChar:TIME_ENDED_MP3];
}

@end
