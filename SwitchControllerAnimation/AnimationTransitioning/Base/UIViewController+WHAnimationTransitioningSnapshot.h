//
//  UIViewController+WHAnimationTransitioningSnapshot.h
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/16.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * Provide a caregory of UIViewController, add a var to get and set screen snapshot.
 */

@interface UIViewController (WHAnimationTransitioningSnapshot)

@property (nonatomic, strong) UIView *snapshot;

@end
