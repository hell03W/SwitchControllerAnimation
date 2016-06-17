//
//  WHBaseAnimationTransitioning.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/14.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "WHBaseAnimationTransitioning.h"

/// 默认动画执行时间间隔
const static NSTimeInterval WHAnimationTransitioningDuration = 0.6;

@interface WHBaseAnimationTransitioning ()

@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) UINavigationControllerOperation transitionType;

@end

@implementation WHBaseAnimationTransitioning

- (instancetype)init {
    
    if (self = [self initWithType:UINavigationControllerOperationPush duration:WHAnimationTransitioningDuration]) {
    }
    return self;
}

// 主要的构造方法
- (instancetype)initWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration {
    
    if (self = [super init]) {
        self.duration = duration;
        self.transitionType = transitionType;
    }
    return self;
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType {
    
    return [self transitionWithType:transitionType duration:WHAnimationTransitioningDuration];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType
                          duration:(NSTimeInterval)duration {
    
    return [self transitionWithType:transitionType duration:duration interactivePopTransition:nil];
}

+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition {
    
    WHBaseAnimationTransitioning *animationTransitioning = [[self alloc] initWithType:transitionType duration:duration];
    animationTransitioning.interactivePopTransition = interactivePopTransition;
    return animationTransitioning;
}


- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {}
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {}
- (void)pushEnded {}
- (void)popEnded {}



#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.transitionType == UINavigationControllerOperationPush) {
        [self push:transitionContext];
    }
    else if (self.transitionType == UINavigationControllerOperationPop) {
        [self pop:transitionContext];
    }
}


- (void)animationEnded:(BOOL) transitionCompleted {

    if (!transitionCompleted) return;

    if (self.transitionType == UINavigationControllerOperationPush) {
        [self pushEnded];
    }
    else if (self.transitionType == UINavigationControllerOperationPop) {
        [self popEnded];
    }
}

@end







