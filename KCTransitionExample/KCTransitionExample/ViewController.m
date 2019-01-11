//
//  ViewController.m
//  KCTransitionExample
//
//  Created by knowchatMac01 on 2019/1/11.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "KCCircleTransition.h"

static NSString *cellID = @"cellID";

@interface ViewController ()<UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) NSArray *aryClassName;
@property (nonatomic, strong) UITableView *tbwShow;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.aryClassName = @[@"KCCircleTransition"];
    
    _tbwShow = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tbwShow.delegate = self;
    _tbwShow.dataSource = self;
    _tbwShow.tableFooterView = [UIView new];
    [_tbwShow registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tbwShow];
}
    
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryClassName.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.aryClassName[indexPath.row];
    return cell;
}
    
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
    
#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    NSIndexPath *indexPathForSelectedRow = [self.tbwShow indexPathForSelectedRow];
    if (indexPathForSelectedRow.row == 0) {
        KCCircleTransition *transition = [[KCCircleTransition alloc] initWithStartFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 40, CGRectGetMidY(self.view.frame) - 40, 80, 80) isShow:(operation == UINavigationControllerOperationPush)];
        return transition;
    }
    return nil;
}

@end
