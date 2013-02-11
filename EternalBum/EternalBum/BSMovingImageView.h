//
//  BSMovingImageView.h
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSMovingImageView : UIImageView
@property (nonatomic, assign)CGSize visibleArea;
- (void)startMove;
@end
