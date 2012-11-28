//
//  VKTwitterFWController.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKPostModel.h"

@interface VKTwitterFWController : NSObject
+ (BOOL)isLogin;
- (id)initWithViewController:(UIViewController *)vc;
@property(nonatomic, assign)UIViewController *vc;
- (void)post:(VKPostModel *)post;
@end
