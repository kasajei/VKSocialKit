//
//  VKPostModel.h
//  VKSocialKitCocos2dSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//
//

#import <Foundation/Foundation.h>
#import "VKSocialKit.h"

@interface VKPostModel : NSObject
@property VKSocialType socialType;
@property(nonatomic, retain) NSString *text;
@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) NSString *url;
@property(nonatomic, copy) void (^complete)(BOOL succuess);
+ (id)create:(VKSocialType)socialType text:(NSString *)text image:(UIImage *)image url:(NSString *)url complete:(void(^)(BOOL success))complete;
@end
