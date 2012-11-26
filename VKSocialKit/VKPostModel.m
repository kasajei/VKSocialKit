//
//  VKPostModel.m
//  VKSocialKitCocos2dSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//
//

#import "VKPostModel.h"

@implementation VKPostModel
+ (id)create:(VKSocialType)socialType text:(NSString *)text image:(UIImage *)image url:(NSString *)url complete:(void(^)(BOOL success))complete{
    VKPostModel *post = [[VKPostModel alloc] init];
    post.text = text;
    post.image = image;
    post.url = url;
    post.complete = complete;
    return post;
}
@end
