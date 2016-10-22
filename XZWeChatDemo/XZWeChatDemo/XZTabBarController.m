//
//  XZTabBarController.m
//  XZWeChatDemo
//
//  Created by 徐章 on 16/9/11.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZTabBarController.h"
#import "XZHomeViewController.h"
#import "XZContactViewController.h"
#import "XZTimeLineViewController.h"
#import "XZMeViewController.h"


#define kViewController @"viewController"
#define kTitle          @"title"
#define kNormalImage    @"normalImage"
#define kSelectImage    @"selectImage"

@interface XZTabBarController ()

@end

@implementation XZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[
                       @{
                           kViewController : NSStringFromClass([XZHomeViewController class]),
                           kTitle          : @"微信",
                           kNormalImage    : @"tabbar_home_normal",
                           kSelectImage    : @"tabbar_home_select"
                           },
                       @{
                           kViewController : NSStringFromClass([XZContactViewController class]),
                           kTitle          : @"联系人",
                           kNormalImage    : @"tabbar_contact_normal",
                           kSelectImage    : @"tabbar_contact_select"
                           },
                       @{
                           kViewController : NSStringFromClass([XZTimeLineViewController class]),
                           kTitle          : @"发现",
                           kNormalImage    : @"tabbar_discover_normal",
                           kSelectImage    : @"tabbar_discover_select"
                           },
                       @{
                           kViewController : NSStringFromClass([XZMeViewController class]),
                           kTitle          : @"我",
                           kNormalImage    : @"tabbar_me_normal",
                           kSelectImage    : @"tabbar_me_select"
                           }
                       ];
    
    
    for (NSDictionary *dic in array) {
        
        UIViewController *vc = [[NSClassFromString(dic[kViewController]) alloc] init];
        vc.navigationItem.title = dic[kTitle];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        
        nav.navigationBar.barTintColor = [UIColor blackColor];
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UITabBarItem *item = nav.tabBarItem;
        item.title = dic[kTitle];
        item.image = [UIImage imageNamed:dic[kNormalImage]];
        item.selectedImage = [[UIImage imageNamed:dic[kSelectImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
