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
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) UIImage *image;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) UIViewController *vc;
@property(nonatomic, copy) void (^complete)(BOOL succuess);

- (void)setScreenShot:(UIView *)view;
- (void)setScreenShotOfVC;
- (void)setGLScreenShot;
@end
