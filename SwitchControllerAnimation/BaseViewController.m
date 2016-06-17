//
//  BaseViewController.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/15.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "BaseViewController.h"
#import "WHNaviController.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation BaseViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    self.snapshot = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    if (self.navigationController != nil && self != self.navigationController.viewControllers.firstObject) {
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        [self.view addGestureRecognizer:popRecognizer];
        popRecognizer.delegate = self;
    }
    
}


#pragma mark - UIPanGestureRecognizer handlers

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer {
    
    CGFloat progress = [recognizer translationInView:self.view].x / CGRectGetWidth(self.view.frame);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        // Create a interactive transition and pop the view controller
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        
        [self.navigationController popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        // Update the interactive transition's progress
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        // Finish or cancel the interactive transition
        if (progress > 0.25) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)recognizer {
    return [recognizer velocityInView:self.view].x > 0;
}

@end
