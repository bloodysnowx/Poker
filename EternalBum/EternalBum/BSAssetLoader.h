//
//  BSAssetLoader.h
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface BSAssetLoader : NSObject

@property (nonatomic, retain) ALAssetsLibrary* assetsLibrary;
@property (nonatomic, retain) NSMutableArray* groups;
@property (nonatomic, retain) ALAssetsGroup* cameraRoll;
@property (nonatomic, retain) NSMutableArray* photos;

- (void)getCameraRolls:(id)target selector:(SEL)aSelector;
@end
