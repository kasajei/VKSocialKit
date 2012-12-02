//
//  VKSocialController.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKPostModel.h"


@interface VKSocialFWController : NSObject
+ (BOOL)isLogin:(NSString *)socialServiceType;
+ (void)showNotAccountSetting:(VKPostModel *)post;
- (void)post:(VKPostModel *)post;
@end
