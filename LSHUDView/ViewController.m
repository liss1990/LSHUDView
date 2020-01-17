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
//    [LSHUDView setCustomHudPosition:-0.2];
    [LSHUDView setHudPosition:LSHUDPOSITION_Top]; 
//    [LSHUDView setHudAnimationType:DGActivityIndicatorAnimationTypeBallGridPulse withColor:[UIColor redColor]];
//    [LSHUDView setSuccessAndFailColor:[UIColor orangeColor]];
//    [LSHUDView setTitleLabelColor:[UIColor redColor]];
//    [LSHUDView setHUDBackColor:[UIColor whiteColor]];
//    [LSHUDView setHudPosition:LSHUDPOSITION_Bottom];
//    [LSHUDView setBackColor:[UIColor colorWithWhite:0.6 alpha:0.3]];
    
//    [LSHUDView setBackViewWithClick:YES];
     
}
- (IBAction)show:(UIButton *)sender {
    [LSHUDView Show];
}
- (IBAction)showTitle:(UIButton *)sender {
    [LSHUDView ShowWithTitle:@"加载中..."];
}
- (IBAction)showSuccess:(UIButton *)sender {
    [LSHUDView ShowSuccessView];
}
- (IBAction)showSuccessTitle:(UIButton *)sender {
    [LSHUDView ShowSuccessWithTitle:@"成功"];
}
- (IBAction)title:(UIButton *)sender {
    [LSHUDView ShowTitle:@"你在看我吗？"];
}
- (IBAction)showFail:(UIButton *)sender {
    [LSHUDView ShowFailView];
}
- (IBAction)showFailtitle:(UIButton *)sender {
    [LSHUDView ShowFailWithTitle:@"失败"];
}
- (IBAction)dism:(UIButton *)sender {
    [LSHUDView dismiss];
}


@end
