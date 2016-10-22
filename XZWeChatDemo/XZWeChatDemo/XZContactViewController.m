//
//  XZContactViewController.m
//  XZWeChatDemo
//
//  Created by 徐章 on 16/9/11.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZContactViewController.h"

@interface XZContactViewController ()

@property (nonatomic, strong) UISearchController *searchVc;

@end

@implementation XZContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.searchVc = [[UISearchController alloc] initWithSearchResultsController:nil];
    

    UISearchBar *bar = self.searchVc.searchBar;
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    
    bar.layer.borderColor = [UIColor redColor].CGColor;
    
    bar.showsBookmarkButton = YES;
    CGRect rect = bar.frame;
    bar.frame = CGRectMake(0, 64, rect.size.width, 44);
//    [self.view addSubview:bar];
    
//    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.tableHeaderView = bar;
//    [self.view addSubview:self.tableView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

@end
