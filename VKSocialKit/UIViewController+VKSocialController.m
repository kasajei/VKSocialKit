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
#import "VKScreenShot.h"


@implementation UIViewController (VKSocialController)

#pragma mark iOS FW
- (void)postWithSocialFW:(VKPostModel *)post {
    VKSocialFWController *socialController = [[VKSocialFWController alloc] initWithViewController:self];
    [socialController post:post];
}

- (void)postWithTwitterFW:(VKPostModel *)post {
    VKTwitterFWController *socialController = [[VKTwitterFWController alloc] initWithViewController:self];
    [socialController post:post];
}


- (void)notSupport{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"not supoorted"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


#pragma mark public method
- (void)post:(VKPostModel *)post{
    // VLSocialTypeから、iOS SocailFWやTwitterFWに対応したStringを作る
    NSString *socialServiceType = [VKSocialKit socialTypeToFrameworkString:post.socialType];
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


- (void)postToSocialService:(VKSocialType )socialType initialText:(NSString *)socialText addImage:(UIImage *)socialImage addURLWithString:(NSString *)socialURLWithString complete:(void(^)(BOOL success))complete{
    VKPostModel *post = [VKPostModel create:socialType text:socialText image:socialImage url:socialURLWithString complete:complete];
    [self post:post];
}


-(void)postScreenShotToSocialService:(VKSocialType)socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void (^)(BOOL))complete{
    UIImage *image = [VKScreenShot captureScreen:self.view];
    [self postToSocialService:socialType initialText:socialText addImage:image addURLWithString:socialURLWithString complete:complete];
}

-(void)postGLScreenShotToSocialService:(VKSocialType)socialType initialText:(NSString *)socialText addURLWithString:(NSString *)socialURLWithString complete:(void (^)(BOOL))complete{
    UIImage *image = [VKScreenShot captureOpenGLScreen];
    [self postToSocialService:socialType initialText:socialText addImage:image addURLWithString:socialURLWithString complete:complete];
}







@end
