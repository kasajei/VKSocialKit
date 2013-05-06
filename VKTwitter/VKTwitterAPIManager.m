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
#pragma mark - ChangeRequestMethdo
+ (SLRequestMethod)getSLRequestMethodFromVKRequestMethod:(VKRequestMethod)requestMethod{
    switch (requestMethod) {
        case kVKRequestGET:
            return SLRequestMethodGET;
            break;
        case kVKRequestPOST:
            return SLRequestMethodPOST;
            break;
        default:
            break;
    }
}

+ (TWRequestMethod)getTWRequestMethodFromVKRequestMethod:(VKRequestMethod)requestMethod{
    switch (requestMethod) {
        case kVKRequestGET:
            return TWRequestMethodGET;
            break;
        case kVKRequestPOST:
            return TWRequestMethodPOST;
            break;
        default:
            break;
    }
}

#pragma mark - Base Request
+ (void)performRequestWithAPIURL:(NSString *)urlString requestMethod:(VKRequestMethod)requestMethod params:(NSDictionary *)params complete:(void(^)(NSData *responseData))complete failure:(void(^)(NSError *error))failure{
    NSString *fullRUL = [NSString stringWithFormat:@"https://api.twitter.com/1.1/%@", urlString];
    NSURL *url = [NSURL URLWithString:fullRUL];
    id request;
    if ([VKSocialKit hasSocialFramework]) {
        request =[SLRequest requestForServiceType:SLServiceTypeTwitter
                                       requestMethod:[self getSLRequestMethodFromVKRequestMethod:requestMethod]
                                                 URL:url
                                          parameters:params
                  ];
    }else if( [VKSocialKit hasTwitterFramework]){
        request = [[TWRequest alloc] initWithURL:url
                                      parameters:params
                                   requestMethod:[self getTWRequestMethodFromVKRequestMethod:requestMethod]
                   ];
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
            if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                NSError *jsonError;
                id JSON = [NSJSONSerialization JSONObjectWithData:responseData
                                                                             options:NSJSONReadingAllowFragments
                                                                               error:&jsonError];
                if (JSON) {
                    complete(JSON);
                }else {
                    NSLog(@"JSON Error: %@", [jsonError localizedDescription]);
                    failure(jsonError);
                }
            }else{
                failure(error);
            }
        }
    }];
}

#pragma mark - APIs
+ (void)statusesUpdate:(NSString *)status complete:(void(^)(id JSON))complete failure:(void(^)(NSError *error))failure{
    NSString *urlString = @"statuses/update.json";
    NSDictionary *params = [NSDictionary dictionaryWithObject:status forKey:@"status"];
    [self performRequestWithAPIURL:urlString requestMethod:kVKRequestPOST params:params complete:complete failure:failure];
}

+ (void)statussMentionsTimeline:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure{
    NSString *urlString = @"statuses/mentions_timeline.json";
    [self performRequestWithAPIURL:urlString requestMethod:kVKRequestGET params:param complete:complete failure:failure];
}

@end
