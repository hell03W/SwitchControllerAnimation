//
//  WHNaviController.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/16.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "WHNaviController.h"
#import "BaseViewController.h"
#import "WHBaseAnimationTransitioning.h"

@interface WHNaviController () <UINavigationControllerDelegate>

@end

@implementation WHNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UINavigationControllerDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(WHBaseAnimationTransitioning *) animationController  {
    
    return animationController.interactivePopTransition;
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(BaseViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    
    Class class = NSClassFromString(@"WHBackPriorViewAnimation"); //self.classStr
    
    if (fromVC.interactivePopTransition) {

        Class classInteractive = NSClassFromString(@"WHBackPriorViewAnimationInteractive");
        WHBaseAnimationTransitioning *baseAnimation = [[classInteractive alloc] initWithType:operation duration:0.6];
        baseAnimation.interactivePopTransition = fromVC.interactivePopTransition;
        return baseAnimation;  // 手势
    }else{
        return [[class alloc] initWithType:operation duration:0.6];  // 非手势
    }
}







@end
