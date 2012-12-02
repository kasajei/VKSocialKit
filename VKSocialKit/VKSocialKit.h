//
//  VKSocialKit.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VKPostModel;

typedef enum VKSocialType {
    kVKTwitter,
    kVKFacebook,
}VKSocialType;


@interface VKSocialKit : NSObject
+ (BOOL)hasSocialFramework;
+ (BOOL)hasTwitterFramework;
+ (NSString *)socialTypeToFrameworkString:(VKSocialType)socialType;
+ (void)post:(VKPostModel *)post complete:(void(^)(BOOL success))complete;
@end
