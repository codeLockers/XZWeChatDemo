//
//  XZHomeViewController.m
//  XZWeChatDemo
//
//  Created by 徐章 on 16/9/11.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZHomeViewController.h"
#import "XZHomeCell.h"
#import "XZEyeView.h"
#import "XZChatViewController.h"

@interface XZHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XZEyeView *eyeView;
@property (nonatomic, strong) UIView *headView;

@end

@implementation XZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
//    [self addGesture];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Load_UI
- (void)loadUI{

    [self loadTableView];
    [self loadHeadView];
    [self loadEyeView];
}

- (void)loadTableView{

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80.0f;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = [UIView new];
    [self.view addSubview:self.tableView];
}

- (void)loadHeadView{

    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    self.headView.layer.masksToBounds = YES;
    [self.tableView.tableHeaderView addSubview: self.headView];
}

- (void)loadEyeView{

    self.eyeView = [[XZEyeView alloc] initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2.0f, 0, 100, 50)];
    
    [self.headView addSubview:self.eyeView];
}

#pragma mark - Private_Methods


#pragma mark - UIScrollView_Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY > -64)
        return;
    
    CGFloat height = -64 - offsetY;
    
    self.headView.frame = CGRectMake(0, -height, [UIScreen mainScreen].bounds.size.width,height);
    self.eyeView.center = CGPointMake(self.eyeView.center.x, height/3.f);
    [self.eyeView setAnimationProgress:height/150.0f];
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XZHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XZHomeCell class])];
    if (!cell) {
        
        cell = [[XZHomeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([XZHomeCell class])];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XZChatViewController *chatVc = [[XZChatViewController alloc] init];
    chatVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatVc animated:YES];
}
@end
