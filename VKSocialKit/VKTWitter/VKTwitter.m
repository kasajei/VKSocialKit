//
//  VKTwitter.m
//  VKSocialKitCocos2dSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//
//

#import "VKTwitter.h"

@implementation VKTwitter
+ (id)createWithViewController:(UIViewController *)vc withPost:(VKPostModel *)post{
    VKTwitter *twitter = [[VKTwitter alloc] init];
    twitter.vc = vc;
    twitter.post = post;
    return twitter;
}

// アカウントがないときの処理
- (void)noAccount{
    
}

@end
