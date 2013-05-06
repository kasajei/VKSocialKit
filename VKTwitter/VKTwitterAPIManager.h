//
//  VKTwitterAPIManager.h
//  Somarufoi2
//
//  Created by Kasajima Yasuo on 2013/04/27.
//  Copyright (c) 2013年 kasajei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  VKRequestMethod{
    kVKRequestGET,
    kVKRequestPOST,
}VKRequestMethod;

@interface VKTwitterAPIManager : NSObject
#pragma mark - APIs
// Twitter API https://dev.twitter.com/docs/api/1.1

#pragma mark - Timelines
+ (void)statusesMentionsTimeline:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
+ (void)statusesUserTimeline:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
+ (void)statusesRetweetsOfMe:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;

#pragma mark - Tweets
+ (void)statusesRetweets:(NSString *)tweetId param:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
+ (void)statusesShow:(NSString *)tweetId param:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
+ (void)statusesDestroy:(NSString *)tweetId param:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
+ (void)statusesUpdate:(NSString *)status param:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError *error))failure;
+ (void)statusesRetweet:(NSString *)tweetId param:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
@end
