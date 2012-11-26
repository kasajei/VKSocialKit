//
//  VKTwitter.h
//  VKSocialKitCocos2dSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//
//

#import <Foundation/Foundation.h>
#import "VKPostModel.h"

@interface VKTwitter : NSObject
@property(nonatomic, assign) UIViewController *vc;
@property(nonatomic, retain) VKPostModel *post;

+ (id)createWithViewController:(UIViewController *)vc withPost:(VKPostModel *)post;
- (void)noAccount;
@end
