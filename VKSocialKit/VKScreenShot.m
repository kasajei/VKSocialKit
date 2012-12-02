//
//  VKScreenShot.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "VKScreenShot.h"
#import <QuartzCore/QuartzCore.h>

@implementation VKScreenShot

#pragma mark Connection to VKAdView
+ (void)addBannerTo:(UIView *)view{
    if (NSClassFromString(@"VKAdView")) {
        NSArray *subviews = view.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:NSClassFromString(@"VKAdView")]) {
                if ([view respondsToSelector:@selector(addOriginalBanner)]) {
                    [view performSelector:@selector(addOriginalBanner)];
                }
            }
        }
    }
}

+ (void)removeBannerFrom:(UIView *)view{
    if (NSClassFromString(@"VKAdView")) {
        NSArray *subviews = view.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:NSClassFromString(@"VKAdView")]) {
                if ([view respondsToSelector:@selector(removeOriginalBanner)]) {
                    [view performSelector:@selector(removeOriginalBanner)];
                }
            }
        }
    }
}

// cocos2dの時に使う
+ (UIImageView *)getOriginalBannerImage{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (NSClassFromString(@"VKAdView")) {
        NSArray *subviews = vc.view.subviews;
        for (UIView *view in subviews) {
            if ([view isKindOfClass:NSClassFromString(@"VKAdView")]) {
                if ([view respondsToSelector:@selector(getOriginalBannerImage)]) {
                    NSLog(@"getOriginalBannerImage");
                    return [view performSelector:@selector(getOriginalBannerImage)];
                }
            }
        }
    }
    return nil;
}


#pragma mark
+ (UIImage *) captureOpenGL{
    CGSize size = [UIScreen mainScreen].applicationFrame.size;
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    size = CGSizeMake(size.width * screenScale, size.height * screenScale);
    NSLog(@"%f",size.width);
    switch ([UIApplication sharedApplication].statusBarOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"よこ");
            size = CGSizeMake(size.height, size.width);
            break;
        default:
            break;
    };
	//Create buffer for pixels
	GLuint bufferLength = size.width * size.height * 4;
	GLubyte* buffer = (GLubyte*)malloc(bufferLength);
    
	//Read Pixels from OpenGL
	glReadPixels(0, 0, size.width, size.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	//Make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
    
	//Configure image
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * size.width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef iref = CGImageCreate(size.width, size.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
	uint32_t* pixels = (uint32_t*)malloc(bufferLength);
	CGContextRef context = CGBitmapContextCreate(pixels, size.width, size.height, 8, size.width * 4, CGImageGetColorSpace(iref), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
	CGContextTranslateCTM(context, 0, size.height);
	CGContextScaleCTM(context, 1.0f, -1.0f);
    
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), iref);
    
    CGImageRef outputImageRef = CGBitmapContextCreateImage(context);
    UIImage *outputImage = [UIImage imageWithCGImage:outputImageRef];
    
	//Dealloc
	CGDataProviderRelease(provider);
	CGImageRelease(iref);
	CGContextRelease(context);
	free(buffer);
	free(pixels);
	return outputImage;
}


+ (UIImage *) captureOpenGLScreen {
    
    // connection To VKAdView
    UIImageView *originalBanner = [self getOriginalBannerImage];
    if ([originalBanner isKindOfClass:[UIImageView class]]) {
        NSLog(@"test original banner %@",originalBanner.image);
        
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        CGRect doubleFrame = CGRectMake(originalBanner.frame.origin.x * screenScale, originalBanner.frame.origin.y * screenScale, originalBanner.frame.size.width * screenScale, originalBanner.frame.size.height * screenScale);
        
        UIImage *image = [self captureOpenGL];
        
        
        
        // 画像を合成
        CGSize size = image.size;
        UIImage *resultImage;
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        [originalBanner.image drawInRect:doubleFrame];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        return resultImage;
    }else{
        // ない場合はそのまま渡す
        return [self captureOpenGL];
    }
}


+ (UIImage *) captureScreen :(UIView *)view{
    // VKAdViewがのっている時に、自社広告をのせる
    [self addBannerTo:view];
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 変更するサイズ
    CGSize size = CGSizeMake(image.size.width * 2, image.size.height * 2);
    
    UIImage *resultImage;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // VKAdViewがのっている時に、自社広告を剥がす
    [self removeBannerFrom:view];
    return resultImage;
}


@end
