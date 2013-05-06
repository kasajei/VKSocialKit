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
+ (void)statusesUpdate:(NSString *)status complete:(void(^)(id JSON))complete failure:(void(^)(NSError *error))failure;
+ (void)statussMentionsTimeline:(NSDictionary *)param complete:(void(^)(id JSON))complete failure:(void(^)(NSError* error))failure;
@end
