//
//  XZHomeCell.m
//  XZWeChatDemo
//
//  Created by 徐章 on 16/9/11.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZHomeCell.h"
#import <SDAutoLayout/SDAutoLayout.h>

#define kDeleteBtnWidth 6.0f
#define kTagBtnWidth    10.0f

#define kShouldSlideX   -2

@interface XZHomeCell()<UIGestureRecognizerDelegate>{
 
    BOOL _shouldSlide;
}

@property (nonatomic, assign) BOOL isSlided;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation XZHomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self loadIconImage];
        [self loadGesture];
    }
    return self;
}

- (void)loadIconImage{

    UIImageView *iconImage = [UIImageView new];
    iconImage.backgroundColor = [UIColor greenColor];
    iconImage.layer.cornerRadius = 5.0f;
    iconImage.layer.masksToBounds = YES;
    
    [self.contentView addSubview:iconImage];
    
    iconImage.sd_layout
    .leftSpaceToView(self.contentView,10)
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10)
    .widthEqualToHeight();
    
    UIButton *deleteBtn = [UIButton new];
    deleteBtn.backgroundColor = [UIColor redColor];
    [self insertSubview:deleteBtn belowSubview:self.contentView];
    
    deleteBtn.sd_layout
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(kDeleteBtnWidth);
    
    UIButton *tagBtn = [UIButton new];
    tagBtn.backgroundColor = [UIColor grayColor];
    [self insertSubview:tagBtn belowSubview:self.contentView];
    
    tagBtn.sd_layout
    .topEqualToView(self)
    .bottomEqualToView(self)
    .rightSpaceToView(deleteBtn, 0)
    .widthIs(kTagBtnWidth);
}

- (void)loadGesture{

    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture_Method:)];
    
    self.panGesture.delegate = self;
    
    [self.contentView addGestureRecognizer:self.panGesture];
}

#pragma mark - Private_Methods
- (void)panGesture_Method:(UIPanGestureRecognizer *)pan{
    
    CGPoint point = [pan translationInView:pan.view];
    
    if (self.contentView.left <= kShouldSlideX) {
        _shouldSlide = YES;
    }
    
    if (fabs(point.y) < 1.0) {
        if (_shouldSlide) {
            [self slideWithTranslation:point.x];
        } else if (fabs(point.x) >= 1.0) {
            [self slideWithTranslation:point.x];
        }
    }
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        CGFloat x = 0;
        if (self.contentView.left < kShouldSlideX && !self.isSlided) {
            x = -(kDeleteBtnWidth + kTagBtnWidth);
        }
        [self cellSlideAnimationWithX:x];
        _shouldSlide = NO;
    }
    
    [pan setTranslation:CGPointZero inView:pan.view];

}

- (void)cellSlideAnimationWithX:(CGFloat)x
{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:2 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.contentView.left = x;
    } completion:^(BOOL finished) {
        self.isSlided = (x != 0);
    }];
}

- (void)slideWithTranslation:(CGFloat)value
{
    if (self.contentView.left < -(kDeleteBtnWidth + kTagBtnWidth) * 1.1 || self.contentView.left > 30) {
        value = 0;
    }
    self.contentView.left += value;
}


#pragma mark - gestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (self.contentView.left <= kShouldSlideX && otherGestureRecognizer != self.panGesture) {
        return NO;
    }
    return YES;
}
@end
