//
//  XZChatViewController.m
//  XZWeChatDemo
//
//  Created by 徐章 on 2016/10/16.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZChatViewController.h"
#import "XZChatCell.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "XZChatModel.h"

@interface XZChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation XZChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUI{

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
}

- (void)loadData{
    
    NSArray *fromArray = @[@"me",@"other",@"me"];
    NSArray *contentArray = @[@"今天是个好日子心想的事儿都能成，疯狂精神焕发克己复礼精神焕发将发挥减肥了sjfhakjhsdfkashdfkjahjdfhakjdsgfhajsfhjagsjfha444",@"fshfkshjfjkashfkljfagslfhslfghas"];
    
    
    
    self.dataArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<10; i++) {
        
        NSInteger index = arc4random() % 3;
        
        XZChatModel *model = [[XZChatModel alloc] init];
        model.from = fromArray[index];
        
        if (index == 2) {
            model.image = [UIImage imageNamed:@"pic3"];
        }else{
            model.content = contentArray[index];
        }
        
        [self.dataArray addObject:model];
    }
}

- (void)loadTableView{

    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[XZChatCell class] forCellReuseIdentifier:NSStringFromClass([XZChatCell class])];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableView_Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [self.tableView cellHeightForIndexPath:indexPath model:self.dataArray[indexPath.row] keyPath:@"model" cellClass:[XZChatCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];

    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZChatCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([XZChatCell class])];
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}
@end
