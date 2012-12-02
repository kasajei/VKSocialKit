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
#import "VKScreenShot.h"
#import "VKSocialFWController.h"
#import "VKTwitterFWController.h"
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

#pragma mark Post Mothod
#pragma mark iOS FW
+ (void)postWithSocialFW:(VKPostModel *)post {
    VKSocialFWController *socialController = [[VKSocialFWController alloc] init];
    [socialController post:post];
}

+ (void)postWithTwitterFW:(VKPostModel *)post {
    VKTwitterFWController *socialController = [[VKTwitterFWController alloc] init];
    [socialController post:post];
}


#pragma mark public method
+ (void)post:(VKPostModel *)post{
    // VLSocialTypeから、iOS SocailFWやTwitterFWに対応したStringを作る
//    NSString *socialServiceType = [VKSocialKit socialTypeToFrameworkString:post.socialType];
    
    // 優先順位が高いもの順
    // socail frameworkがある場合 iOS6以上
    if([VKSocialKit hasSocialFramework])
    {
        [self postWithSocialFW:post];
        return;
    }
    
    // twitterでtwitter fwがある場合
    if (post.socialType == kVKTwitter && [VKSocialKit hasTwitterFramework]) {
        [self postWithTwitterFW:post];
        return;
    }
    
    // facebookでiOS5の場合
    // TODO :
    [self notSupport];
}

+ (void)post:(VKPostModel *)post complete:(void(^)(BOOL success))complete{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    post.complete = complete;
    [self post:post];
}

@end
