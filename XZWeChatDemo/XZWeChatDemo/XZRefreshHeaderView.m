//
//  XZRefreshHeaderView.m
//  XZWeChatDemo
//
//  Created by 徐章 on 2016/10/30.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZRefreshHeaderView.h"
#import <SDAutoLayout/SDAutoLayout.h>

@interface XZRefreshHeaderView()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *refreshIcon;
@end


@implementation XZRefreshHeaderView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadImageView];
        [self loadHeaderImageView];
        [self loadRefreshIcon];
    }
    return self;
}

- (void)loadImageView{
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.image = [UIImage imageNamed:@"timelinebg"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backgroundImageView];
    
    self.backgroundImageView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(250);
}

- (void)loadHeaderImageView{

    self.headerImageView = [[UIImageView alloc] init];
    self.headerImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.headerImageView];
    
    self.headerImageView.sd_layout
    .rightSpaceToView(self,20)
    .heightIs(50)
    .widthIs(50)
    .bottomEqualToView(self);
}

- (void)loadRefreshIcon{

    self.refreshIcon = [[UIImageView alloc] init];
    self.refreshIcon.image = [UIImage imageNamed:@"loadRefreshIcon"];
    
    
    
}

@end
