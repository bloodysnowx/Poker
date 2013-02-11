//
//  BSPhotoMasker.m
//  EternalBum
//
//  Created by Atsushi Iwasa on 2013/02/11.
//  Copyright (c) 2013年 bloodysnow. All rights reserved.
//

#import "BSPhotoMasker.h"

@implementation BSPhotoMasker

+ (UIImage*)maskImageBak:(UIImage*)origin
{
    CGImageRef imageRef = origin.CGImage;
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    // ピクセルを構成するRGB各要素が何ビットで構成されている
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    // ピクセル全体は何ビットで構成されているか
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    // 画像の横1ライン分のデータが、何バイトで構成されているか
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    // 画像の色空間
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    // 画像のBitmap情報
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    // 画像がピクセル間の補完をしているか
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    // 表示装置によって補正をしているか
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    // 画像のデータプロバイダを取得する
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    // データプロバイダから画像のbitmap生データ取得
    CFDataRef tmpData = CGDataProviderCopyData(dataProvider);
    CFMutableDataRef data = CFDataCreateMutableCopy(0, 0, tmpData);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    // 1ピクセルずつ画像を処理
    NSUInteger x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8* tmp;
            tmp = buffer + y * bytesPerRow + x * 4; // RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
                                                    // RGB値を取得
            UInt8 *alpha;
            alpha = tmp + 3;
            *(tmp + 0) = (UInt8)10;
            // NSLog(@"%o", *tmp);
            // *alpha = 0.5;
            
        }
    }
    // 効果を与えたデータ生成
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    // 効果を与えたデータプロバイダを生成
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    // 画像を生成
    CGImageRef effectedCgImage = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider, NULL,
                                               shouldInterpolate, intent);
    UIImage* effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    // データの解放
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

+ (UIImage*)maskImage:(UIImage*)origin AlphaCoeff:(double)filterCoeff
{
    CGImageRef imageRef = origin.CGImage;
    int width = CGImageGetWidth(imageRef);
    int height = CGImageGetHeight(imageRef);
    unsigned char *data = malloc(width * height * sizeof(unsigned char) * 4);
    CGContextRef bitmapContext = CGBitmapContextCreate(data, width, height, 8, width * 4,
                                                       CGColorSpaceCreateDeviceRGB(),
                                                       kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(bitmapContext, CGRectMake(0,0,width,height), imageRef);
    unsigned char *bitmap = CGBitmapContextGetData(bitmapContext);
    double center_x = width / 2.0;
    double center_y = height / 2.0;
    for(int x = 0; x < width; ++x)
        {
        for(int y = 0; y < height; ++y)
            {
            int i = (x + y * width) * 4;
            double x_from_center = (x - center_x) / center_x;
            double y_from_center = (y - center_y) / center_y;
            unsigned char alpha = MIN(255, 255 * MAX(0, (filterCoeff - x_from_center * x_from_center - y_from_center * y_from_center)));
            
            bitmap[i + 3] = alpha;
            }
        }
    /*
     for(int i = 0; i < width * height * 4;){
     bitmap[i] = bitmap[i++];
     bitmap[i] = bitmap[i++];
     bitmap[i] = bitmap[i++];
     bitmap[i] = 255 * 0.9;  //alpha 半透明にしちゃう
     i++;
     }
     */
    
    CGDataProviderRef dataProviderRef;
    dataProviderRef = CGDataProviderCreateWithData(NULL,
                                                   bitmap,
                                                   width * height * 4,
                                                   NULL);
    CGImageRef invertCGImage = CGImageCreate(width,
                                             height,
                                             8,//size_t bitsPerComponent,
                                             32,//size_t bitsPerPixel,
                                             width * 4,//size_t bytesPerRow,
                                             CGColorSpaceCreateDeviceRGB(),
                                             kCGImageAlphaLast,
                                             dataProviderRef,
                                             NULL,
                                             0,
                                             kCGRenderingIntentDefault);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0,0,width,height), invertCGImage);
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    free(data);
    CGDataProviderRelease(dataProviderRef);
    // CGImageRelease(imageRef);
    return result;
}

@end
