//
//  VKTwitterAccountManager.m
//  Somarufoi2
//
//  Created by Kasajima Yasuo on 2013/04/27.
//  Copyright (c) 2013年 kasajei. All rights reserved.
//

#import "VKTwitterAccountManager.h"

@implementation VKTwitterAccountManager

+ (VKTwitterAccountManager *)sharedInstance
{
    static dispatch_once_t once;
    static VKTwitterAccountManager *instance;
    dispatch_once(&once, ^ { instance = [[VKTwitterAccountManager alloc] init]; });
    return instance;
}

- (id)init{
    if ( (self = [super init]) ) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        _username = [ud stringForKey:kUDVKTwitterAccountUsername];
        _userNameToIdDic = [ud objectForKey:kUDVKTwitterAccountUsernameToIdDic];
        [self selectTwitterUser:_username];
    }
    return self;
}

- (void)getTwitterIDListSaved:(void(^)(NSArray *usernameAry))saved new:(void(^)(NSArray *usernameAry))new failure:(void(^)(NSError *error))failure{
    
    NSMutableArray *alreadyUserName = [[NSMutableArray alloc] init];
    for (NSString *key in _userNameToIdDic) {
        [alreadyUserName addObject:key];
    }
    if (alreadyUserName.count > 0) {
        saved(alreadyUserName);
    }
    
	ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    __weak typeof(self) wSelf = self;
	[accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
		if(granted) {
            _accountAry = [accountStore accountsWithAccountType:accountType];
            NSMutableArray *usernameAry = [[NSMutableArray alloc] init];
            _userNameToIdDic = [[NSMutableDictionary alloc] init];
            for (ACAccount *account in _accountAry) {
                [usernameAry addObject:[account username]];
                [_userNameToIdDic setObject:[account identifier] forKey:[account username]];
            }
            new(usernameAry);
            
            __strong typeof(wSelf) sSelf = wSelf;
            if (sSelf) {
                [wSelf saveUsernameToDic];
            }
		}else{
            failure(error);
        }
	}];
}

- (void)selectTwitterUser:(NSString*)username{
    _username = username;
    NSString *identifer = [_userNameToIdDic objectForKey:_username];
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    _selectedAccount = [accountStore accountWithIdentifier:identifer];
    NSLog(@"%@",_userNameToIdDic);
    NSLog(@"%@",_selectedAccount.username);
    
    // 保存する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_username forKey:kUDVKTwitterAccountUsername];
    [ud synchronize];
}

- (void)saveUsernameToDic{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:_userNameToIdDic forKey:kUDVKTwitterAccountUsernameToIdDic];
    [ud synchronize];
}

@end
