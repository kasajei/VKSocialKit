//
//  VKSocialKit.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "VKSocialKit.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "UIViewController+VKSocialController.h"
#import "VKScreenShot.h"
#define TWTWITTER @"TWTwitter"


@implementation VKSocialKit
#pragma mark useful method
+ (BOOL)hasSocialFramework{
    return NSClassFromString(@"SLComposeViewController") != nil;
}

+ (BOOL)hasTwitterFramework{
    return NSClassFromString(@"TWTweetComposeViewController") != nil;
}

+ (NSString *)socialTypeToFrameworkString:(VKSocialType)socialType{
    switch (socialType) {
        case kVKTwitter:
            if ([self hasSocialFramework])
                return SLServiceTypeTwitter;
            else
                return TWTWITTER;
            break;
        case kVKFacebook:
            if ([self hasSocialFramework]) {
                return SLServiceTypeFacebook;
            }
            break;
        default:
            break;
    }
    return nil;
}

+ (void)notSupport{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"not supoorted"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


#pragma mark public method
+ (void)postToSocialService:(VKSocialType )socialType initialText:(NSString *)socialText addImage:(UIImage *)socialImage addURLWithString:(NSString *)socialURLWithString complete:(void(^)(BOOL success))complete{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc postToSocialService:socialType initialText:socialText addImage:socialImage addURLWithString:socialURLWithString complete:complete];
}


+ (void)postScreenShotToSocialService:(VKSocialType)socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void (^)(BOOL))complete{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIImage *image = [VKScreenShot captureScreen:vc.view];
    [VKSocialKit postToSocialService:socialType initialText:socialText addImage:image addURLWithString:socialURLWithString complete:complete];
}

+ (void)postGLScreenShotToSocialService:(VKSocialType)socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void (^)(BOOL))complete{
    UIImage *image = [VKScreenShot captureOpenGLScreen];
    [VKSocialKit postToSocialService:socialType initialText:socialText addImage:image addURLWithString:socialURLWithString complete:complete];
}


@end
