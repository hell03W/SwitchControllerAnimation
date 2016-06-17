//
//  SecondViewController.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/13.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "SecondViewController.h"
#import "WHBaseAnimationTransitioning.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    
    [self configUI];
}

- (void)configUI {
    self.view.backgroundColor = [UIColor redColor];
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
