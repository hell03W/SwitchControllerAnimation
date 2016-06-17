//
//  PushFromBottom.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/14.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "WHPushFromBottomAnimation.h"

@implementation WHPushFromBottomAnimation

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    fromVc.view.hidden = YES;
    [[transitionContext containerView] addSubview:fromVc.snapshot];
    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, CGRectGetHeight(bounds));
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         fromVc.snapshot.alpha = 0.5;
                         toVc.navigationController.view.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         fromVc.view.hidden = NO;
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         [transitionContext completeTransition:YES];
                     }];
}

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
    
    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.5;
    
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(bounds));
                         toVc.snapshot.alpha = 1.0;
                         toVc.snapshot.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                         toVc.navigationController.navigationBar.hidden = NO;
                         toVc.view.hidden = NO;
                         
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         fromVc.snapshot = nil;
                         
                         // Reset toViewController's `snapshot` to nil
                         if (![transitionContext transitionWasCancelled]) {
                             toVc.snapshot = nil;
                         }
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end


@implementation WHPushFromBottomAnimationInteractive

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
    
    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.5;
    
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(bounds));
                         toVc.snapshot.alpha = 1.0;
                         toVc.snapshot.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         
                         toVc.navigationController.navigationBar.hidden = NO;
                         toVc.view.hidden = NO;
                         
                         [fromVc.snapshot removeFromSuperview];
                         [toVc.snapshot removeFromSuperview];
                         fromVc.snapshot = nil;
                         
                         // Reset toViewController's `snapshot` to nil
                         if (![transitionContext transitionWasCancelled]) {
                             toVc.snapshot = nil;
                         }
                         
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
