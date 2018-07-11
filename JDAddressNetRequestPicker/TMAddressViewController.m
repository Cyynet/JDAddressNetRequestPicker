//
//  TMAddressViewController.m
//  JDAddressNetRequestPicker
//
//  Created by cocomanber on 2018/7/9.
//  Copyright © 2018年 cocomanber. All rights reserved.
//

#import "TMAddressViewController.h"

#import "TMAddressView.h"

@interface TMAddressViewController ()

@property (nonatomic, strong)UIButton *buttonSelected;
@property (nonatomic, strong)UILabel *labelAddress;

@end

@implementation TMAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"选择" forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 200, 0, 0);
    [button sizeToFit];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addressButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20, 100, 300, 50);
    _labelAddress = label;
    [self.view addSubview:label];
}

- (void)addressButton{
//    TMAddressView *view = [[TMAddressView alloc] initWithFrame:self.view.bounds];
//    [view showInView:self.view];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    TMAddressView *view = [[TMAddressView alloc] initWithFrame:window.bounds];
    [view showInView:window];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
