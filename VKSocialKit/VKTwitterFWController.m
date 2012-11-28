//
//  VKTwitterFWController.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "VKTwitterFWController.h"
#import <Twitter/Twitter.h>


@implementation VKTwitterFWController

+ (BOOL)isLogin{
    return [TWTweetComposeViewController canSendTweet];
}

#pragma mark LifeCycle
- (id)initWithViewController:(UIViewController *)vc{
    if ((self = [self init])) {
        self.vc = vc;
    }
    return self;
}

- (void)post:(VKPostModel *)post{
    TWTweetComposeViewController *twitterController = [[TWTweetComposeViewController alloc] init];
    [twitterController setCompletionHandler:^(TWTweetComposeViewControllerResult result)
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
    [twitterController setInitialText:post.text];
    [twitterController addImage:post.image];
    [twitterController addURL:[NSURL URLWithString:post.url]];
    [self.vc presentViewController:twitterController animated:YES completion:nil];
}




@end
