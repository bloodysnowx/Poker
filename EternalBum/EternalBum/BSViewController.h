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

@interface BSViewController : UIViewController<UIAccelerometerDelegate, BSAssetLoaderDelegate>

@property (nonatomic, retain) IBOutlet BSMovingImageView* backView;
@property (nonatomic, retain) IBOutlet UIImageView* pictureUpView;
@property (nonatomic, retain) IBOutlet UIImageView* pictureDownView;

@end
