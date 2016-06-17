//
//  WHBaseAnimationTransitioning.h
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/14.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+WHAnimationTransitioningSnapshot.h"


@interface WHBaseAnimationTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

/// 创建动画效果的实例对象并设置动画类型, push or pop
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType;

/// 创建动画效果的实例对象并设置动画类型和间隔时间
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration;

/// 创建动画效果实例对象并设置动画类型/间隔时间/可交互属性
+ (instancetype)transitionWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration interactivePopTransition:(UIPercentDrivenInteractiveTransition *)interactivePopTransition;

- (instancetype)initWithType:(UINavigationControllerOperation)transitionType duration:(NSTimeInterval)duration;

#pragma mark - 真正实现 push, pop 动画的方法, 具体实现交给子类
- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext;

- (void)pushEnded;
- (void)popEnded;

@end
