//
//  VKPostModel+cocos2d.m
//  DashOtaku
//
//  Created by Kasajima Yasuo on 2012/12/10.
//  Copyright (c) 2012年 kyoto. All rights reserved.
//

#import "VKPostModel+cocos2d.h"
#import "cocos2d.h"
#import "VKScreenShot.h"

@implementation VKPostModel (cocos2d)
- (void)setCocos2dImage{
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    CCNode *n = [scene.children objectAtIndex:0];
    [CCDirector sharedDirector].nextDeltaTimeZero = YES;
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    CCRenderTexture* rtx =
    [CCRenderTexture renderTextureWithWidth:winSize.width
                                     height:winSize.height];
    [rtx begin];
    [n visit];
    [rtx end];
    UIImage *image = [rtx getUIImageFromBuffer];
    self.image = [VKScreenShot blendAdImageOn:image];
}
@end
