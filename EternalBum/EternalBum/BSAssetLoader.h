//
//  BSAssetLoader.h
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@protocol BSAssetLoaderDelegate<NSObject>

- (void)loadBackImagesComplete:(NSMutableArray*)photos;
- (void)loadCameraRollComplete:(NSMutableArray*)photos;

@end

@interface BSAssetLoader : NSObject

@property (nonatomic, retain) ALAssetsLibrary* assetsLibrary;
@property (nonatomic, retain) ALAssetsGroup* cameraRoll;
@property (nonatomic, retain) ALAssetsGroup* backsFolder;
@property (nonatomic, retain) NSMutableArray* photos;
@property (nonatomic, retain) NSMutableArray* backImages;

- (void)getCameraRolls:(id<BSAssetLoaderDelegate>)target selector:(SEL)aSelector;
- (void)getBacks:(id<BSAssetLoaderDelegate>)target selector:(SEL)aSelector;
@end
