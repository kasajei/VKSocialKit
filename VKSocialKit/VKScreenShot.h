//
//  VKScreenShot.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKScreenShot : NSObject
+ (UIImage *) captureOpenGLScreen ;
+ (UIImage *) captureScreen :(UIView*)view;
+ (UIImage *) blendAdImageOn:(UIImage *)image;
@end

