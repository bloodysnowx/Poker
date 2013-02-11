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

- (void)getCameraRolls:(id)target selector:(SEL)aSelector
{
    self.assetsLibrary = [ALAssetsLibrary new];
    self.target = target;
    self.selector = aSelector;
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
            [self.target performSelector:self.selector onThread:curent withObject:self.photos waitUntilDone:NO];
		}
	};
    
	ALAssetsFilter* onlyPhotosFilter = [ALAssetsFilter allPhotos];
	[self.cameraRoll setAssetsFilter:onlyPhotosFilter];
    [self.cameraRoll enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetsEnumerationBlock];
}
@end
