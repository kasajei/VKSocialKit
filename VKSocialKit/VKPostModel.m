//
//  VKPostModel.m
//  VKSocialKitCocos2dSample
//
//  Created by Kasajima Yasuo on 2012/11/25.
//
//

#import "VKPostModel.h"
#import "VKScreenShot.h"

@implementation VKPostModel
#pragma get method
-(UIViewController *)vc{
    if (!_vc)
        self.vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    return _vc;
}

#pragma mark screenshot
- (void)setScreenShot:(UIView *)view{
    self.image = [VKScreenShot captureScreen:view];
}

- (void)setScreenShotOfVC{
    self.image = [VKScreenShot captureScreen:self.vc.view];
}

- (void)setGLScreenShot{
    self.image = [VKScreenShot captureOpenGLScreen];
}
@end
