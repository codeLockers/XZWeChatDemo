//
//  XZEyeView.m
//  XZWeChatDemo
//
//  Created by 徐章 on 16/9/11.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZEyeView.h"
#import <SDAutoLayout/SDAutoLayout.h>

@interface XZEyeView()


@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XZEyeView

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadImageView];
    }
    return self;
}

- (void)loadImageView{

    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sight_capture_mask"]];
    [self addSubview:self.imageView];
    
    self.imageView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self);
    
}

- (void)setAnimationProgress:(CGFloat)progress{

    CGFloat eyeViewProgress = MIN(progress, 1);
    CGFloat w = CGRectGetWidth(self.imageView.frame) * eyeViewProgress;
    CGFloat h = CGRectGetHeight(self.imageView.frame);
    if (w < h) {
        h = w;
    }
    CGFloat x = (CGRectGetWidth(self.imageView.frame) - w) * 0.5;
    CGFloat y = (CGRectGetHeight(self.imageView.frame) - h) * 0.5;
    CGRect rect = CGRectMake(x, y, w, h);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.fillColor = [UIColor redColor].CGColor;
    mask.path = path.CGPath;
    
    
    self.imageView.layer.mask = mask;

}

@end
