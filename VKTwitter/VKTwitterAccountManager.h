//
//  VKTwitterAccountManager.h
//  Somarufoi2
//
//  Created by Kasajima Yasuo on 2013/04/27.
//  Copyright (c) 2013年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

#pragma mark - Constant Parameter
// for NSUserDefaults
static  NSString *const kUDVKTwitterAccountUsername = @"/VKTWitter/TwitterUsername"; // 前に使用していたTwitterIDAccount
static  NSString *const kUDVKTwitterAccountUsernameToIdDic = @"/VKTWitter/UsernameToIdDic"; // Twitterのアカウント一覧

@interface VKTwitterAccountManager : NSObject{
    NSArray *_accountAry;
    NSMutableDictionary *_userNameToIdDic;
}
@property(readonly ,nonatomic) NSString *username;
@property(readonly, nonatomic) ACAccount *selectedAccount;

#pragma mark - Class Methods
+ (VKTwitterAccountManager *)sharedInstance;
#pragma mark - Instance Methdos
- (void)getTwitterIDListSaved:(void(^)(NSArray *usernameAry))saved new:(void(^)(NSArray *usernameAry))new failure:(void(^)(NSError *error))failure;
- (void)selectTwitterUser:(NSString*)username;
@end
