//
//  BSViewController.m
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import "BSAssetLoader.h"
#import "BSPhotoMasker.h"

@interface BSViewController ()
{
    double filterCoeff;
    UIImage* upImage;
    UIImage* downImage;
}

@property (nonatomic, retain)BSAssetLoader * loader;
@property (nonatomic, retain) NSMutableArray* photos;
@property (nonatomic, assign) int currentNum;
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation BSViewController

static const int X_MARGIN = 40;
static const int Y_MARGIN = 60;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // [self setUpGesture];
    filterCoeff = 1.2;
    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 6.0f/60.0f;
}

- (void)accelerometer:(UIAccelerometer *)acel
        didAccelerate:(UIAcceleration *)acceleration {
    
    if(acceleration.x * acceleration.x + acceleration.y * acceleration.y + acceleration.z * acceleration.z > 2.0)
    {
        NSLog(@"shaked");
        [self.timer invalidate];
        self.currentNum = arc4random() % [self.photos count];
        [self startSlideShow];
    }
}

- (IBAction)up:(id)sender
{
    if(filterCoeff < 3.0)
    {
        filterCoeff += 0.1;
        [self resetPictures];
    }
}

- (IBAction)down:(id)sender
{
    if(filterCoeff > 0.8)
    {
        filterCoeff -= 0.1;
        [self resetPictures];
    }
}

- (IBAction)prev:(id)sender
{
    [self.timer invalidate];
    [self startSlideShow];
}

- (IBAction)next:(id)sender
{
    [self.timer invalidate];
    self.currentNum -= 4;
    if(self.currentNum < 0) self.currentNum += [self.photos count];
    [self startSlideShow];
}

- (void)loadComplete:(NSMutableArray*)photos
{
    self.photos = photos;
    self.currentNum = arc4random() % [self.photos count];
    [self performSelectorOnMainThread:@selector(startSlideShow) withObject:nil waitUntilDone:NO];
}

- (void)startSlideShow
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(slideChangeWithAnime) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)slideChangeWithAnime
{
    [UIView animateWithDuration:0.5 animations:^void{
        self.pictureUpView.transform = CGAffineTransformMakeRotation(0.0);
        self.pictureUpView.alpha = 0.2;
        self.pictureUpView.frame = CGRectMake(150, self.backView.frame.size.height / 4, 20, 20);
        self.pictureDownView.transform = CGAffineTransformMakeRotation(0.0);
        self.pictureDownView.alpha = 0.3;
        self.pictureDownView.frame = CGRectMake(150, self.backView.frame.size.height * 3 / 4, 20, 20);
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^void{
            [self relocatePictureView];
            self.pictureUpView.alpha = 1.0;
            self.pictureDownView.alpha = 1.0;
        } completion:^(BOOL finished){
            
        }];
    }];
}

- (void)relocatePictureView:(UIImageView*)view Image:(UIImage*)origin HeightOffset:(CGFloat)offset
{
    view.transform = CGAffineTransformMakeRotation(0.0);
    int x = arc4random() % X_MARGIN;
    int y = arc4random() % Y_MARGIN;
    int width = self.backView.frame.size.width - x - arc4random() % X_MARGIN;
    int height = self.backView.frame.size.height - y - arc4random() % Y_MARGIN;
    y += offset;
    view.frame = CGRectMake(x, y, width, height);
    [self setPicture:view Image:origin];
    int deg = (arc4random() % 60 - 30 + 360 + 180) % 360;
    NSLog(@"x =  %d, y = %d, width = %d, height = %d, deg = %d", x, y, width, height, deg);
    view.transform = CGAffineTransformMakeRotation(M_PI * deg / 180.0f);
}

- (UIImage*)getCurrentImage
{
    ALAsset* asset = self.photos[self.currentNum++ % [self.photos count]];
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    return [UIImage imageWithCGImage:[representation fullScreenImage]];
}

- (void)resetPictures
{
    [self setPicture:self.pictureUpView Image:upImage];
    [self setPicture:self.pictureDownView Image:downImage];
}

- (void)setPicture:(UIImageView*)view Image:(UIImage*)origin
{
    view.image = [BSPhotoMasker maskImage:origin AlphaCoeff:filterCoeff];
}

- (void)relocatePictureView
{
    upImage = [self getCurrentImage];
    downImage = [self getCurrentImage];
    [self relocatePictureView:self.pictureUpView Image:upImage HeightOffset:-self.backView.frame.size.height/4];
    [self relocatePictureView:self.pictureDownView Image:downImage HeightOffset:self.backView.frame.size.height/4];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.loader = [BSAssetLoader new];
    [self.loader getCameraRolls:self selector:@selector(loadComplete:)];
    [self.backView startMove];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
