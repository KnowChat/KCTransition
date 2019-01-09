//
//  KCCircleTransition.h
//  KCTransition
//
//  Created by knowchatMac01 on 2019/1/9.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KCCircleTransition : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>
/**
 初始化方法

 @param startFrame isShow = YES时，为开始扩大区域；isShow = NO时，为最终缩小区域
 @param isShow 是否是出现
 @return Transition
 */
- (instancetype)initWithStartFrame:(CGRect)startFrame isShow:(BOOL)isShow;
@end

