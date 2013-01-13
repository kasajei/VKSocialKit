//
//  ViewController.m
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import "ViewController.h"
#import "UIKitHelper.h"
#import "UIViewController+VKSocialController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)pressTweet:(id)sender{
    VKPostModel *post = [[VKPostModel alloc] init];
    post.socialType = kVKTwitter;
    post.text = @"テスト";
    [post setScreenShot:self.view];
    
    [self post:post complete:^(BOOL success){
        NSLog(@"おっけー");
    }];
}

- (void)pressFacebook:(id)sender{
    VKPostModel *post = [[VKPostModel alloc] init];
    post.socialType = kVKFacebook;
    post.text = @"テスト";
    [post setScreenShot:self.view];
    
    [self post:post complete:^(BOOL success){
        NSLog(@"おっけー");
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self installButtonNamed:@"Tweet" inPosition:CGPointMake(0, 0)];
    [self installButtonNamed:@"Facebook" inPosition:CGPointMake(0, 50)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
