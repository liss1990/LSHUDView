//
//  ViewController.m
//  LSHUDView
//
//  Created by Ebuy EDITSUITE MAC on 2020/1/6.
//  Copyright © 2020 Lisisi. All rights reserved.
//

#import "ViewController.h"
#import "LSHUDView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LSHUDView setMinimumDismissTimeInterval:1.5];
    [LSHUDView setCustomHudPosition:-0.25];
    [LSHUDView setHudAnimationType:DGActivityIndicatorAnimationTypeTriplePulse withColor:[UIColor redColor]];
    [LSHUDView setSuccessAndFailColor:[UIColor orangeColor]];
    [LSHUDView setTitleLabelColor:[UIColor redColor]];
//    [LSHUDView setHudPosition:LSHUDPOSITION_Bottom];
//    [LSHUDView setBackColor:[UIColor colorWithWhite:0.6 alpha:0.3]];
    
//    [LSHUDView setBackViewWithClick:YES];
     
}
- (IBAction)show:(UIButton *)sender {
    [LSHUDView Show];
}
- (IBAction)showTitle:(UIButton *)sender {
    [LSHUDView ShowWithTitle:@"想麻烦啦是啦解放啦圣诞节啦剪短发啦进啦发牢骚加拉加斯地方了"];
}
- (IBAction)showSuccess:(UIButton *)sender {
    [LSHUDView ShowSuccessView];
}
- (IBAction)showSuccessTitle:(UIButton *)sender {
    [LSHUDView ShowSuccessWithTitle:@"成功成功成功成功成功成功成功成999887987功成功成功成功成功成功2222"];
}
- (IBAction)title:(UIButton *)sender {
    [LSHUDView ShowTitle:@"你在看我吗？你在看我吗？你在看我吗？你在看我吗？你在看我吗？"];
}
- (IBAction)showFail:(UIButton *)sender {
    [LSHUDView ShowFailView];
}
- (IBAction)showFailtitle:(UIButton *)sender {
    [LSHUDView ShowFailWithTitle:@"失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败失败111"];
}
- (IBAction)dism:(UIButton *)sender {
    [LSHUDView dismiss];
}


@end
