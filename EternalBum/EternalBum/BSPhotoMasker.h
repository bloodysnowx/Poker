//
//  BSPhotoMasker.h
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSPhotoMasker : NSObject

+ (UIImage*)maskImage:(UIImage*)origin AlphaCoeff:(double)filterCoeff;

@end
