//
//  UIViewController+VKSocialController.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "UIViewController+VKSocialController.h"
#import "VKSocialFWController.h"
#import "VKTwitterFWController.h"


@implementation UIViewController (VKSocialController)

#pragma mark iOS FW
- (void)post:(VKPostModel *)post complete:(void(^)(BOOL success))complete{
    post.vc = self;
    post.complete = complete;
    [VKSocialKit post:post complete:complete];
}

- (void)post:(VKPostModel *)post withScreenShot:(BOOL)flag complete:(void(^)(BOOL success))complete{
    if (flag)
        [post setScreenShot:self.view];
    
    [self post:post complete:complete];
}

@end
