//
//  VKTwitterAPIManager.m
//  Somarufoi2
//
//  Created by Kasajima Yasuo on 2013/04/27.
//  Copyright (c) 2013年 kasajei. All rights reserved.
//

#import "VKTwitterAPIManager.h"
#import <Social/Social.h>
#import <Twitter/Twitter.h>
#import "VKTwitterAccountManager.h"
#import "VKSocialKit.h"

@implementation VKTwitterAPIManager
#pragma mark - Base Request
+ (void)performRequestWithAPIURL:(NSString *)urlString params:(NSDictionary *)params complete:(void(^)(NSData *responseData))complete failure:(void(^)(NSError *error))failure{
    NSURL *url = [NSURL URLWithString:urlString];
    id request;
    if ([VKSocialKit hasSocialFramework]) {
        request =[SLRequest requestForServiceType:SLServiceTypeTwitter
                                       requestMethod:SLRequestMethodPOST
                                                 URL:url
                                          parameters:params];
    }else if( [VKSocialKit hasTwitterFramework]){
        request = [[TWRequest alloc] initWithURL:url
                                      parameters:params
                                   requestMethod:TWRequestMethodPOST];
    }else{
        return;
    }
    
    if (![VKTwitterAccountManager sharedInstance].selectedAccount) {
        NSError *error = [NSError errorWithDomain:@"VKTwitter.AccountError" code:400 userInfo:nil];
        failure(error);
        return;
    }
    ACAccount *account = [VKTwitterAccountManager sharedInstance].selectedAccount;    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
	ACAccount *account2 = [accountStore accountWithIdentifier:account.identifier];
	
    [request setAccount:account2];
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (error) {
            failure(error);
        }else{
            complete(responseData);
        }
    }];
}

#pragma mark - APIs
+ (void)statusesUpdate:(NSString *)status complete:(void(^)(NSData *responseData))complete failure:(void(^)(NSError *error))failure{
    NSString *urlString = @"https://api.twitter.com/1.1/statuses/update.json";
    NSDictionary *params = [NSDictionary dictionaryWithObject:status forKey:@"status"];
    [self performRequestWithAPIURL:urlString params:params complete:complete failure:failure];
}
@end
