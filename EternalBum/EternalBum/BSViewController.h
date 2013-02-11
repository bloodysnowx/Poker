//
//  BSViewController.h
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSAssetLoader.h"
#import "BSMovingImageView.h"

@interface BSViewController : UIViewController<UIAccelerometerDelegate, BSAssetLoaderDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, retain) IBOutlet BSMovingImageView* backView;
@property (nonatomic, retain) IBOutlet UIImageView* pictureUpView;
@property (nonatomic, retain) IBOutlet UIImageView* pictureDownView;
- (IBAction)up:(id)sender;
- (IBAction)down:(id)sender;
- (IBAction)prev:(id)sender;
- (IBAction)next:(id)sender;

@end
