//
//  VKSocialController.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "VKSocialFWController.h"
#import <Social/Social.h>
#import "VKSocialKit.h"
#import "VKTwitter.h"


@implementation VKSocialFWController


#pragma mark Class Method
+ (BOOL)isLogin:(NSString *)socialServiceType{
    return [SLComposeViewController isAvailableForServiceType:socialServiceType];
}

+ (void)showNotAccountSetting:(VKPostModel *)post vc:(UIViewController *)vc{
    NSString *title;
    switch (post.socialType) {
        case kVKTwitter:
            [[VKTwitter createWithViewController:vc withPost:post] noAccount];
            return;
            break;
        case kVKFacebook:
            title = @"No Facebook Accounts";
            break;
        default:
            break;
    }
    NSString *message = @"There are no accounts configured. You can add or create an account in Settings.";
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark LifeCycle
-(id)initWithViewController:(UIViewController *)vc{
    if ((self = [self init])) {
        self.vc = vc;
    }
    return self;
}

#pragma mark PostMethod
- (void)post:(VKPostModel *)post{
    NSString *socialServiceType = [VKSocialKit socialTypeToFrameworkString:post.socialType];
    SLComposeViewController *socialController = [SLComposeViewController composeViewControllerForServiceType:socialServiceType];
    [socialController setCompletionHandler:^(SLComposeViewControllerResult result)
     {
         
         NSString *message;
         BOOL success = false;
         switch(result)
         {
             case SLComposeViewControllerResultCancelled:
                 message = NSLocalizedString(@"Cancelled", nil);
                 break;
             case SLComposeViewControllerResultDone:
                 message = NSLocalizedString(@"Done", nil);
                 success = true;
                 break;
             default:
                 break;
         }
         NSLog(@"%@", message);
         
         [self.vc dismissViewControllerAnimated:YES completion:^{
             if (post.complete) {
                 post.complete(success);
             }
         }];
     }];
    [socialController setInitialText:post.text];
    [socialController addImage:post.image];
    [socialController addURL:[NSURL URLWithString:post.url]];
    [self.vc presentViewController:socialController animated:YES completion:nil];

}
@end
