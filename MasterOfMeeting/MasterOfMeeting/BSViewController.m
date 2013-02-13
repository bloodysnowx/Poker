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

static const char* const TIME_WARNING_MP3 = "800_WARNING";
static const char* const TIME_ENDED_MP3 = "810_ENDING";
static const char* const NOTHING_MP3 = "600_NOTHING";
static const char* const SEYASEYA_MP3 = "610_SEYASEYA";
static const int WARNING_TIME = 30;
static const int ENDING_TIME = 30;

- (void)playChar:(const char* const)path WillDelegate:(BOOL)flag
{
    NSURL* fileURL = [self getURLfromBundleChar:path];
    [self play:fileURL WillDelegate:flag];
}

- (void)play:(NSURL*)fileURL WillDelegate:(BOOL)flag
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    player.delegate = flag ? self : nil;
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
    NSArray* filePaths = [[NSArray alloc] initWithObjects:@"010_OP", @"020_ED", nil];
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
    [self play:fileURLs[nowCount++] WillDelegate:NO];
    [self performSelector:@selector(timeWarning) withObject:nil afterDelay:WARNING_TIME];
}

-(void)timeWarning
{
    [self playChar:TIME_WARNING_MP3 WillDelegate:NO];
    [self performSelector:@selector(timeEnded) withObject:nil afterDelay:ENDING_TIME];
}

-(void)timeEnded
{
    [self playChar:TIME_ENDED_MP3 WillDelegate:NO];
}

@end
