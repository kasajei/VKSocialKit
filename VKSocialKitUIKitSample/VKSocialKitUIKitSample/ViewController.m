//
//  ViewController.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "ViewController.h"
#import "UIKitHelper.h"
#import "SVProgressHUD.h"
#import "UIViewController+VKSocialController.h"
#import "VKTwitterAccountManager.h"
#import "VKTwitterAPIManager.h"

@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController


#pragma mark UserAction
- (void)pressTweet:(id)sender{
    VKPostModel *post = [[VKPostModel alloc] init];
    post.socialType = kVKTwitter;
    post.text = @"test text";
    [post setScreenShot:self.view];
    
    [self post:post complete:^(BOOL success){
        NSLog(@"complete");
    }];
}

- (void)pressFacebook:(id)sender{
    VKPostModel *post = [[VKPostModel alloc] init];
    post.socialType = kVKFacebook;
    post.text = @"test text";
    [post setScreenShot:self.view];
    
    [self post:post complete:^(BOOL success){
        NSLog(@"complete");
    }];
}

- (void)pressAccount:(id)sender {
    
    [SVProgressHUD showWithStatus:@"please wait.." maskType:SVProgressHUDMaskTypeGradient];
	[[VKTwitterAccountManager sharedInstance] getTwitterIDListSaved:^(NSArray *usernameAry) {
        
    } new:^(NSArray *usernameAry) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
            actionSheet.delegate = self;
            [actionSheet setTitle:@"Please select Account"];
            for (NSString *username in usernameAry) {
                [actionSheet addButtonWithTitle:username];
            }
            [actionSheet setCancelButtonIndex:[actionSheet addButtonWithTitle:@"cancel"]];
            [actionSheet showInView:self.view];
        });
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
}

- (void)pressTweetFromAccount:(id)sender{
    if([VKTwitterAccountManager sharedInstance].username != NULL){
        // if setting twitter account , tweet
        [VKTwitterAPIManager statusesUpdate:@"Test Tweet #VKTwitter https://github.com/kasajei/VKSocialKit" complete:^(NSData *responseData) {
            NSLog(@"complete tweet");
        } failure:^(NSError *error) {
            NSLog(@"failure %@", error.description);
        }];
    }
}

- (void)pressAPITest:(id)sender{
    if([VKTwitterAccountManager sharedInstance].username != NULL){
        [VKTwitterAPIManager statussMentionsTimeline:nil complete:^(id JSON) {
            NSArray *array = (NSArray *)JSON;
            NSLog(@"complete %d", array.count);
        } failure:^(NSError *error) {
            NSLog(@"failure %@",error.description);
        }];
    }
}


#pragma mark UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self installButtonNamed:@"Tweet" inPosition:CGPointMake(0, 0)];
    [self installButtonNamed:@"Facebook" inPosition:CGPointMake(0, 50)];
    [self installButtonNamed:@"Account" inPosition:CGPointMake(0, 100)];
    self.tweetBtn = [self installButtonNamed:@"TweetFromAccount" inPosition:CGPointMake(0, 150)];
    [self.tweetBtn setSize:CGSizeMake(320, 50)];
    [self installButtonNamed:@"APITest" inPosition:CGPointMake(0, 200)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma  mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"cancel"]) {
		return;
	}
    // アカウントを設定
    NSString *username = [actionSheet buttonTitleAtIndex:buttonIndex];
    [[VKTwitterAccountManager sharedInstance] selectTwitterUser:username];
    NSString *tweetFromAccount = [NSString stringWithFormat:@"tweet from %@",username];
    [self.tweetBtn setTitle:tweetFromAccount forState:UIControlStateNormal];
}


@end
