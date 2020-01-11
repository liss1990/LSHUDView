//
//  LSShowView.h
//  Demo
//
//  Created by Ebuy EDITSUITE MAC on 2020/1/3.
//  Copyright © 2020 Lisisi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"
typedef enum : NSUInteger {
    LSHUDPOSITION_Top,
    LSHUDPOSITION_Center,
    LSHUDPOSITION_Bottom,
    LSHUDPOSITION_Custom,
} LSHUDPOSITION;


typedef enum : NSUInteger {
    LSHUDTYPE_SHOW,
    LSHUDTYPE_LOADING,
    LSHUDTYPE_SUCCESS,
    LSHUDTYPE_FAIL,
    LSHUDTYPE_TITLE,
} LSHUDTYPE;

NS_ASSUME_NONNULL_BEGIN
@interface LSHUDView : UIView 
@property (strong, nonatomic, nonnull) UIColor *stateColor;
@property (strong, nonatomic, nonnull) UIColor *titleColor;
@property (assign, nonatomic) NSTimeInterval dismissTime;
@property (assign, nonatomic) BOOL isTouch;
@property (assign, nonatomic) LSHUDPOSITION position;
@property (assign, nonatomic) CGFloat positionOffset;
///顶部状态的颜色
+ (void)setStateColor:(UIColor*)color;
//文本颜色
+ (void)setTitleLabelColor:(UIColor*)color;
//设置背景色
+ (void)setBackColor:(UIColor*)color;
//设置消失时间
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;

//设置是否可以被点击
+ (void)setBackViewWithClick:(BOOL)isTouch;
///设置展示的位置
+(void)setHudPosition:(LSHUDPOSITION)position;
///自定义位置
+(void)setCustomHudPosition:(CGFloat)positionOffset;
///选择样式
+(void)setHudAnimationType:(DGActivityIndicatorAnimationType)type withColor:(UIColor*)color;
///设置成功失败颜色
+(void)setSuccessAndFailColor:(UIColor*)color;
///设置Hud背景色
+(void)setHUDBackColor:(UIColor*)color;


+(void)Show;

+(void)ShowWithTitle:(NSString*)str;

+(void)dismiss;

+(void)ShowSuccessView;

+(void)ShowFailView;

+(void)ShowTitle:(NSString*)title;

+(void)ShowSuccessWithTitle:(NSString*)title;

+(void)ShowFailWithTitle:(NSString*)title;




@end

NS_ASSUME_NONNULL_END
