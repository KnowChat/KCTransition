//
//  ViewController.m
//  KCTransition
//
//  Created by knowchatMac01 on 2019/1/9.
//  Copyright © 2019年 Hangzhou knowchat Information Technology Co., Ltd. All rights reserved.
//

#import "ViewController.h"
#import "KCCircleTransition.h"
#import "TestViewController.h"

@interface ViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIButton *btnPush;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btnPush = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 80, 44)];
    self.btnPush.backgroundColor = [UIColor blueColor];
    [self.btnPush setTitle:@"Push" forState:UIControlStateNormal];
    [self.btnPush setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnPush.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [self.btnPush addTarget:self action:@selector(pushEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPush];
}

- (void)pushEvent {
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    CGRect rect = self.btnPush.frame;
    if (operation == UINavigationControllerOperationPush) {
        KCCircleTransition *transition = [[KCCircleTransition alloc] initWithStartFrame:rect isShow:YES];
        return transition;
    }else if (operation == UINavigationControllerOperationPop) {
        KCCircleTransition *transition = [[KCCircleTransition alloc] initWithStartFrame:rect isShow:NO];
        return transition;
    }
    return nil;
}

@end
