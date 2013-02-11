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
#import <AssetsLibrary/AssetsLibrary.h>

@interface BSViewController ()

@property (nonatomic, assign)CGSize visibleArea;

@property (nonatomic, retain) ALAssetsLibrary* assetsLibrary;
@property (nonatomic, retain) NSMutableArray* groups;
@property (nonatomic, retain) ALAssetsGroup* cameraRoll;
@property (nonatomic, retain) NSMutableArray* photos;
@property (nonatomic, assign) int currentNum;
@property (nonatomic, retain) NSTimer *timer;

@end

@implementation BSViewController

static const int ANIMATION_DURATION = 15;
static const int X_MARGIN = 40;
static const int Y_MARGIN = 60;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    [self setUpGesture];
}

- (void)addGestureWithTarget:(id)target action:(SEL)selector direction:(UISwipeGestureRecognizerDirection)direction {
	UISwipeGestureRecognizer* swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:selector];
	swipeLeftGesture.direction = direction;
	// Viewへ関連付け
	[self.view addGestureRecognizer:swipeLeftGesture];
}

- (void) setUpGesture
{
    // 右へ : 未来
	[self addGestureWithTarget:self action:@selector(prev) direction:UISwipeGestureRecognizerDirectionRight];
	// 左へ : 過去
	[self addGestureWithTarget:self action:@selector(next) direction:UISwipeGestureRecognizerDirectionLeft];
}

- (void)prev
{
    [self.timer invalidate];
    [self startSlideShow];
}

- (void)next
{
    [self.timer invalidate];
    self.currentNum -= 4;
    if(self.currentNum < 0) self.currentNum += [self.photos count];
    [self startSlideShow];
}

- (void)getCameraRollGroups
{
    NSThread* current = [NSThread currentThread];
    self.groups = [[NSMutableArray alloc] init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listCameraRollBlock = ^(ALAssetsGroup * group, BOOL * stop) {
		if(group) {
			[self.groups addObject:group];
		} else {
			self.cameraRoll = self.groups[0];
			[self performSelector:@selector(getCameraRollPhotos) onThread:current withObject:nil waitUntilDone:YES];
		}
	};
    
	[self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:listCameraRollBlock failureBlock:nil];
}

- (void)getCameraRollPhotos
{
    NSThread* curent = [NSThread currentThread];
    self.photos = [NSMutableArray arrayWithCapacity:[self.cameraRoll numberOfAssets]];
    
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset * result, NSUInteger index, BOOL * stop) {
		if(result) {
            [self.photos addObject:result];
        }
        else {
            [self performSelector:@selector(startSlideShow) onThread:curent withObject:nil waitUntilDone:NO];
		}
	};
    
	ALAssetsFilter* onlyPhotosFilter = [ALAssetsFilter allPhotos];
	[self.cameraRoll setAssetsFilter:onlyPhotosFilter];
    [self.cameraRoll enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetsEnumerationBlock];
	// [self.cameraRoll enumerateAssetsUsingBlock:assetsEnumerationBlock];
}

- (void)startSlideShow
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(slideChangeWithAnime) userInfo:nil repeats:YES];
    [self.timer fire];
}

- (void)slideChangeWithAnime
{
    [UIView animateWithDuration:0.5 animations:^void{
        self.pictureUpView.alpha = 0.2;
        self.pictureDownView.alpha = 0.3;
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^void{
            [self relocatePictureView];
            self.pictureUpView.alpha = 1.0;
            self.pictureDownView.alpha = 1.0;
        } completion:^(BOOL finished){
            
        }];
    }];
}

- (void)relocatePictureView:(UIImageView*)view HeightOffset:(CGFloat)offset
{
    view.transform = CGAffineTransformMakeRotation(0.0);
    int x = arc4random() % X_MARGIN;
    int y = arc4random() % Y_MARGIN;
    int width = self.backView.frame.size.width - x - arc4random() % X_MARGIN;
    int height = self.backView.frame.size.height - y - arc4random() % Y_MARGIN;
    y += offset;
    view.frame = CGRectMake(x, y, width, height);
    ALAsset* asset = self.photos[self.currentNum++ % [self.photos count]];
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    view.image = [UIImage imageWithCGImage:[representation fullScreenImage]];
    // self.pictureView.layer.anchorPoint = CGPointMake(0, 0);
    int deg = (arc4random() % 60 - 30 + 360) % 360;
    NSLog(@"x =  %d, y = %d, width = %d, height = %d, deg = %d", x, y, width, height, deg);
    view.transform = CGAffineTransformMakeRotation(M_PI * deg / 180.0f);
}

- (void)relocatePictureView
{
    [self relocatePictureView:self.pictureUpView HeightOffset:-self.backView.frame.size.height/4];
    [self relocatePictureView:self.pictureDownView HeightOffset:self.backView.frame.size.height/4];
}

- (void)calcVisibleArea
{
    CGImageRef imageRef = [self.backView.image CGImage];
    float imgW = (float)CGImageGetWidth(imageRef);
    float imgH = (float)CGImageGetHeight(imageRef);
    float viewW = self.backView.frame.size.width;
    float viewH = self.backView.frame.size.height;
    
    float aspect;
    CGRect resizedRect;
    
    if (viewW/imgW < viewH/imgH) {
        aspect = (viewW/viewH * imgH/imgW);
        resizedRect = CGRectMake(0, 0, viewW / aspect, viewH);
        self.visibleArea = CGSizeMake(1.0, aspect);
    } else {
        aspect = (viewH/viewW * imgW/imgH);
        resizedRect = CGRectMake(0, 0, viewW, viewH / aspect);
        self.visibleArea = CGSizeMake(aspect, 1.0);
    }
}

- (void)startMove
{
    CGRect toRect = CGRectMake(1.0 - self.visibleArea.height, 1.0 - self.visibleArea.width, 1, 1);
    NSValue* center      = [NSValue valueWithCGRect:CGRectMake(0, 0, 1, 1)]; // 中央
    NSValue* bottomRight = [NSValue valueWithCGRect:CGRectMake( toRect.origin.x / 2.0,  toRect.origin.y / 2.0, 1, 1)]; // 左端 or 上端
    NSValue* topLeft     = [NSValue valueWithCGRect:CGRectMake(-toRect.origin.x / 2.0, -toRect.origin.y / 2.0, 1, 1)]; // 右端 or 下端
    
    CAKeyframeAnimation* swipeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contentsRect"];
    swipeAnimation.duration = ANIMATION_DURATION / MIN(self.visibleArea.width, self.visibleArea.height);
    // swipeAnimation.repeatCount = FLT_MAX;
    swipeAnimation.repeatCount = FLT_MAX;
    swipeAnimation.values = [[NSArray alloc] initWithObjects:
                             center,
                             topLeft,
                             center,
                             bottomRight,
                             center,
                             nil];
    
    swipeAnimation.delegate = self;
    swipeAnimation.removedOnCompletion = YES;
    
    [self.backView.layer addAnimation:swipeAnimation forKey:@"contentsRect"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getCameraRollGroups];
    [self calcVisibleArea];
    NSLog(@"visible area = %f, %f", self.visibleArea.width, self.visibleArea.height);
    [self startMove];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
