//
//  ViewController.m
//  XHFilterCamera
//
//  Created by CraneTeng on 16/9/23.
//  Copyright © 2016年 CraneTeng. All rights reserved.
//

#import "ViewController.h"
#import "XHFilterViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [button setTitle:@"点击发布照片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(presentReleaseShowVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)presentReleaseShowVC {
    XHFilterViewController *vc = [[XHFilterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
