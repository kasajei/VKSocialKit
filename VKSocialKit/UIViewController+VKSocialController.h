//
//  UIViewController+VKSocialController.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSocialKit.h"
#import "VKPostModel.h"

@interface UIViewController (VKSocialController)
// post
- (void)post:(VKPostModel *)post complete:(void(^)(BOOL success))complete;
- (void)post:(VKPostModel *)post withScreenShot:(BOOL)flag complete:(void(^)(BOOL success))complete;
@end
