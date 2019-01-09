//
//  KCCircleTransition.m
//  KCTransition
//
//  Created by knowchatMac01 on 2019/1/9.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import "KCCircleTransition.h"

@interface KCCircleTransition ()
/**
 是否是出现
 */
@property (nonatomic, assign) BOOL isShow;

/**
 isShow = YES时，为开始扩大区域；isShow = NO时，为最终缩小区域
 */
@property (nonatomic, assign) CGRect startFrame;

/**
 transition上下文
 */
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@end

@implementation KCCircleTransition
- (instancetype)initWithStartFrame:(CGRect)startFrame isShow:(BOOL)isShow {
    if (self = [super init]) {
        self.startFrame = startFrame;
        self.isShow = isShow;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.001;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    self.transitionContext = transitionContext;
    UIView *from = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *to = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *vwAnim = to;
    CGFloat startRadius = 1;
    CGFloat endRadius = [self getMinFullScreenRadius];
    if (!self.isShow) {
        vwAnim = from;
        startRadius = endRadius;
        endRadius = 1;
    }
    
    [transitionContext.containerView addSubview:to];
    if (self.isShow) {
        to.frame = transitionContext.containerView.frame;
    }else {
        to.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), CGRectGetHeight(UIScreen.mainScreen.bounds));
        [transitionContext.containerView sendSubviewToBack:to];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = vwAnim.bounds;
    vwAnim.layer.mask = shapeLayer;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor blackColor].CGColor;
    
    UIBezierPath *start = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.startFrame), CGRectGetMidY(self.startFrame)) radius:startRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *end = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.startFrame), CGRectGetMidY(self.startFrame)) radius:endRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    //扩散
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (__bridge id _Nullable)(start.CGPath);
    pathAnimation.toValue = (__bridge id _Nullable)(end.CGPath);
    pathAnimation.duration = 0.4;
    pathAnimation.beginTime = CACurrentMediaTime();
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.delegate = self;
    [shapeLayer addAnimation:pathAnimation forKey:nil];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    UIView *vwAnim = [self.transitionContext viewForKey:UITransitionContextToViewKey];
    if (!self.isShow) {
        vwAnim = [self.transitionContext viewForKey:UITransitionContextFromViewKey];
    }
    vwAnim.layer.mask = nil;
    vwAnim = nil;
    [self.transitionContext completeTransition:YES];
}

- (CGFloat)getMinFullScreenRadius {
    CGFloat xWidth = CGRectGetMidX(self.startFrame) > CGRectGetWidth(UIScreen.mainScreen.bounds) / 2.0 ? CGRectGetMidX(self.startFrame) : CGRectGetWidth(UIScreen.mainScreen.bounds) - CGRectGetMidX(self.startFrame);
    CGFloat yHeight = CGRectGetMidY(self.startFrame) > CGRectGetHeight(UIScreen.mainScreen.bounds) / 2.0 ? CGRectGetMidY(self.startFrame) : CGRectGetHeight(UIScreen.mainScreen.bounds) - CGRectGetMidY(self.startFrame);
    return sqrt(pow(xWidth, 2)+pow(yHeight, 2));
}
@end
