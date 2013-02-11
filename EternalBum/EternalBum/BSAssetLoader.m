//
//  BSAssetLoader.m
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSAssetLoader.h"

@interface BSAssetLoader()
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation BSAssetLoader

- (void)getCameraRolls:(id<BSAssetLoaderDelegate>)target selector:(SEL)aSelector;
{
    self.assetsLibrary = [ALAssetsLibrary new];
    self.target = target;
    self.selector = aSelector;
    ALAssetsLibraryGroupsEnumerationResultsBlock listCameraRollBlock = ^(ALAssetsGroup * group, BOOL * stop) {
		if(group)
            self.cameraRoll = group;
		else
        {
            self.photos = [NSMutableArray arrayWithCapacity:[self.cameraRoll numberOfAssets]];
            [self performSelector:@selector(getGroupPhotos:Array:) withObject:self.cameraRoll withObject:self.photos];
        }
	};
    
	[self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:listCameraRollBlock failureBlock:nil];
}

- (void)getGroupPhotos:(ALAssetsGroup*)group Array:(NSMutableArray*)array
{
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset * result, NSUInteger index, BOOL * stop) {
		if(result)
            [array addObject:result];
        else
            [self.target performSelectorOnMainThread:self.selector withObject:self.photos waitUntilDone:NO];
	};
    
	ALAssetsFilter* onlyPhotosFilter = [ALAssetsFilter allPhotos];
	[group setAssetsFilter:onlyPhotosFilter];
    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetsEnumerationBlock];
}

- (void)getBacks:(id<BSAssetLoaderDelegate>)target selector:(SEL)aSelector
{
    self.target = target;
    self.selector = aSelector;
    ALAssetsLibraryGroupsEnumerationResultsBlock listAlbumBlock = ^(ALAssetsGroup * group, BOOL * stop) {
		if(group) {
            if([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:@"backs"])
                self.backsFolder = group;
		} else
        {
            self.backImages = [[NSMutableArray alloc] initWithCapacity:[self.backsFolder numberOfAssets]];
			[self performSelector:@selector(getGroupPhotos:Array:) withObject:self.backsFolder withObject:self.backImages];
        }
	};
    
	[self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listAlbumBlock failureBlock:nil];
}

@end
