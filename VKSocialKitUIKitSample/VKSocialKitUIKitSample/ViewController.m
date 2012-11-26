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
    [self postScreenShotToSocialService:kVKTwitter initialText:@"test" addURLWithString:nil complete:^(BOOL success){
        if (success) {
            NSLog(@"おめでとう");
        }
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self installButtonNamed:@"Tweet" inPosition:CGPointMake(0, 0)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
