//
//  MoreViewController.m
//  CardLeap
//
//  Created by Sky on 14/11/21.
//  Copyright (c) 2014年 Sky. All rights reserved.
//

#import "MoreViewController.h"
#import "ShopListViewController.h"
@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set navbar title
    [self setNavBarTitle:@"进入商家" withFont:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ShopListViewController *firVC = [[ShopListViewController alloc] init];
    [firVC setNavBarTitle:@"商家" withFont:14.0f];
    firVC.is_hidden = @"0";
    [self.navigationController pushViewController:firVC animated:YES];
}


@end
