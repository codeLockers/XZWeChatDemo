//
//  XZChatCell.m
//  XZWeChatDemo
//
//  Created by 徐章 on 2016/10/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZChatCell.h"
#import <SDAutoLayout/SDAutoLayout.h>
#define kMaxChatImageViewWidth 200.f
#define kMaxChatImageViewHeight 300.f

@interface XZChatCell()

@property (nonatomic, strong) UIView *iconView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *messageImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@end

@implementation XZChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //iconView
        self.iconView = [UIView new];
        self.iconView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.iconView];
        
        //containerView
        self.containerView = [UIView new];
        self.containerView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.containerView];
        
        //Label
        self.label = [UILabel new];
//        self.label.backgroundColor = [UIColor yellowColor];
        [self.containerView addSubview:self.label];
        
        //backgroundImageView
        self.backgroundImageView = [UIImageView new];
//        [self.containerView addSubview:self.backgroundImageView];
        [self.containerView insertSubview:self.backgroundImageView atIndex:0];
        
        self.backgroundImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        //messageImageView
        self.messageImageView = [UIImageView new];
        [self.containerView addSubview:self.messageImageView];
        
        //maskImageView
        self.maskImageView = [UIImageView new];
        
        [self setupAutoHeightWithBottomView:self.containerView bottomMargin:0];
    }
    return self;
}

- (void)setModel:(XZChatModel *)model{

    [self layoutIconView:model.from];
    [self layoutContainerView:model];
    
    if (model.image) {
        
        [self layoutImageView:model];
        
    }else{
    
        [self layoutLabel:model];
    }
}

- (void)layoutIconView:(NSString *)from{
    
    
    if ([from isEqualToString:@"other"]) {
    
        self.iconView.sd_resetLayout
        .leftSpaceToView(self.contentView,10)
        .topSpaceToView(self.contentView,10)
        .widthIs(40)
        .heightIs(40);
        
    }else if ([from isEqualToString:@"me"]){
        
        self.iconView.sd_resetLayout
        .topSpaceToView(self.contentView,10)
        .rightSpaceToView(self.contentView,10)
        .widthIs(40)
        .heightIs(40);
    }
}

- (void)layoutImageView:(XZChatModel *)model{
    
    [self.containerView clearAutoWidthSettings];
    self.messageImageView.hidden = NO;
    
    self.messageImageView.image = model.image;
    // 根据图片的宽高尺寸设置图片约束
    CGFloat standardWidthHeightRatio = kMaxChatImageViewWidth / kMaxChatImageViewHeight;
    CGFloat widthHeightRatio = 0;
    UIImage *image = model.image;
    CGFloat h = image.size.height;
    CGFloat w = image.size.width;
    
    if (w > kMaxChatImageViewWidth || w > kMaxChatImageViewHeight) {
        
        widthHeightRatio = w / h;
        
        if (widthHeightRatio > standardWidthHeightRatio) {
            w = kMaxChatImageViewWidth;
            h = w * (image.size.height / image.size.width);
        } else {
            h = kMaxChatImageViewHeight;
            w = h * widthHeightRatio;
        }
    }
    
    self.messageImageView.size = CGSizeMake(w, h);
    self.containerView.sd_layout.widthIs(w).heightIs(h);
    
    [self.containerView setupAutoHeightWithBottomView:self.messageImageView bottomMargin:0];
    self.containerView.layer.mask = self.maskImageView.layer;
    
    __weak typeof(self) weakself = self;
    [self.backgroundImageView setDidFinishAutoLayoutBlock:^(CGRect frame) {
        // 在_containerBackgroundImageView的frame确定之后设置maskImageView的size等于containerBackgroundImageView的size
        weakself.maskImageView.size = frame.size;
    }];

}

- (void)layoutLabel:(XZChatModel *)model{

    [self.containerView.layer.mask removeFromSuperlayer];
    
    self.messageImageView.hidden = YES;
    
    // 清除展示图片时候_containerBackgroundImageView用到的didFinishAutoLayoutBlock
    self.backgroundImageView.didFinishAutoLayoutBlock = nil;
    
    self.label.text = model.content;
    
    self.label.sd_resetLayout
    .leftSpaceToView(self.containerView,5)
    .topSpaceToView(self.containerView,5)
    .autoHeightRatio(0);
    
    [self.label setSingleLineAutoResizeWithMaxWidth:200];
    
    [self.containerView setupAutoHeightWithBottomView:self.label bottomMargin:10];
    [self.containerView setupAutoWidthWithRightView:self.label rightMargin:5];
}

- (void)layoutContainerView:(XZChatModel *)model{

    if ([model.from isEqualToString:@"me"]) {
    
        self.containerView.sd_resetLayout
        .topEqualToView(self.iconView)
        .rightSpaceToView(self.iconView,10);
        
        self.backgroundImageView.image = [[UIImage imageNamed:@"SenderTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
        
    }else if ([model.from isEqualToString:@"other"]){
        
        self.containerView.sd_resetLayout
        .topEqualToView(self.iconView)
        .leftSpaceToView(self.iconView,10);
        
        self.backgroundImageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg"] stretchableImageWithLeftCapWidth:50 topCapHeight:30];
    }
    
    self.maskImageView.image = self.backgroundImageView.image;
}
@end
