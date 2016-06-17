//
//  UIViewController+WHAnimationTransitioningSnapshot.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/16.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "UIViewController+WHAnimationTransitioningSnapshot.h"
#import <objc/runtime.h>

@implementation UIViewController (WHAnimationTransitioningSnapshot)



- (UIView *)snapshot {
    
    UIView *view = objc_getAssociatedObject(self, @"WHAnimationTransitioningSnapshot");
    if (!view) {
        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    
    return view;
}

- (void)setSnapshot:(UIView *)snapshot {
    
    objc_setAssociatedObject(self, @"WHAnimationTransitioningSnapshot", snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end
