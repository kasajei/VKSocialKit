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

@interface ViewController ()<UIActionSheetDelegate>

@end

@implementation ViewController

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
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
	[accountStore requestAccessToAccountsWithType:accountType withCompletionHandler:^(BOOL granted, NSError *error) {
		if(granted) {
            _accountAry = [accountStore accountsWithAccountType:accountType];
            UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
            actionSheet.delegate = self;
            [actionSheet setTitle:@"selct your account"];
            for (ACAccount *account in _accountAry) {
                [actionSheet addButtonWithTitle:[account username]];
            }
            [actionSheet setCancelButtonIndex:[actionSheet addButtonWithTitle:@"cancel"]];
            [actionSheet showInView:self.view];
            [SVProgressHUD dismiss];
		}else{
            [SVProgressHUD showErrorWithStatus:@"error"];
        }
	}];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"cancel"]) {
		return;
	}
    _selectedAccount = [_accountAry objectAtIndex:buttonIndex];
    NSLog(@"%@",_selectedAccount.username);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self installButtonNamed:@"Tweet" inPosition:CGPointMake(0, 0)];
    [self installButtonNamed:@"Facebook" inPosition:CGPointMake(0, 50)];
    [self installButtonNamed:@"Account" inPosition:CGPointMake(0, 100)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
