//
//  WHBackPriorViewAnimation.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/16.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "WHBackPriorViewAnimation.h"


@implementation WHBackPriorViewAnimation

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    fromVc.view.hidden = YES;
    [[transitionContext containerView] addSubview:fromVc.snapshot];
    [[transitionContext containerView] addSubview:toVc.view];
    [[toVc.navigationController.view superview] insertSubview:fromVc.snapshot belowSubview:toVc.navigationController.view];
    toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.snapshot.alpha = 0.3;
                         fromVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
                         toVc.navigationController.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
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
    toVc.snapshot.alpha = 0.3;
    toVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
    
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    
    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:1.0
          initialSpringVelocity:0.1f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
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



// 正常的动画使用 SpringWithDamping 类型的动画; 使用手势pop时候, 使用这个类, 使用普通样式的动画, 因为这时候使用SpringWithDamping类型动画会导致滑动过快.
@implementation WHBackPriorViewAnimationInteractive

- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    [fromVc.view addSubview:fromVc.snapshot];
    fromVc.navigationController.navigationBar.hidden = YES;
    fromVc.view.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
    
    toVc.view.hidden = YES;
    toVc.snapshot.alpha = 0.3;
    toVc.snapshot.transform = CGAffineTransformMakeScale(0.965, 0.965);
    
    [[transitionContext containerView] addSubview:toVc.view];
    [[transitionContext containerView] addSubview:toVc.snapshot];
    [[transitionContext containerView] sendSubviewToBack:toVc.snapshot];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         fromVc.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(bounds), 0.0);
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

