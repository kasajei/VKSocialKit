//
//  ViewController.h
//  VKSocialKitUIKitSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//  Copyright (c) 2012年 kasajei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accounts/Accounts.h>


@interface ViewController : UIViewController{
    NSArray *_accountAry;
    ACAccount *_selectedAccount;
}

@property(nonatomic, weak) UIButton *tweetBtn;
@end
