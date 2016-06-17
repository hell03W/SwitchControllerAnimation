//
//  ViewController.m
//  SwitchControllerAnimation
//
//  Created by  www.6dao.cc on 16/6/13.
//  Copyright © 2016年 ledao. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
//#import "WHPushFromBottomAnimation.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@"WHPushFromBottomAnimation",
                       @"WHBackPriorViewAnimation",
                       @"WHPushToLeftAnimation",
                       @"animation4"];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.   

    [self.view addSubview:self.tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SecondViewController *secondController = [[SecondViewController alloc] init];
    secondController.classStr = self.dataArray[indexPath.row];
//    self.navigationController.delegate = secondController;
    [self.navigationController pushViewController:secondController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
