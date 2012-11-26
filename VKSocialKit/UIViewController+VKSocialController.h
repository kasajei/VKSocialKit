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
- (void)post:(VKPostModel *)post;
// すべての引数あり
- (void)postToSocialService:(VKSocialType )socialType initialText:(NSString *)socialText addImage:(UIImage *)socialImage addURLWithString:(NSString *)socialURLWithString complete:(void(^)(BOOL success))complete;
// screenshotを取る
- (void)postScreenShotToSocialService:(VKSocialType )socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void(^)(BOOL success))complete;
// openGLのscreenshotを取る
- (void)postGLScreenShotToSocialService:(VKSocialType )socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void(^)(BOOL success))complete;
@end
