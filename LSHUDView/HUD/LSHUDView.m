//
//  LSShowView.m
//  Demo
//
//  Created by Ebuy EDITSUITE MAC on 2020/1/3.
//  Copyright © 2020 Lisisi. All rights reserved.
//
#import <Masonry/Masonry.h>  
#import "LSHUDView.h"
#import "DGActivityIndicatorView.h"
#import "LSFailView.h"
#import "LSSuccessView.h"

#define LSW [UIScreen mainScreen].bounds.size.width
#define LSH [UIScreen mainScreen].bounds.size.height


@interface LSHUDView()
//
@property (nonatomic, strong) UIControl *controlView;
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)DGActivityIndicatorView *activityIndicatorView;
@property(nonatomic,strong)LSFailView *failView;
@property(nonatomic,strong)LSSuccessView *successView;
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, readonly) UIWindow *frontWindow;
@end



@implementation LSHUDView
 

+ (LSHUDView*)sharedView {
    static dispatch_once_t once;
    
    static LSHUDView *sharedView;
#if !defined(SV_APP_EXTENSIONS)
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds];sharedView.frame = CGRectMake(0, 0, LSW, LSH);
        sharedView.dismissTime = 1.8;
        sharedView.isTouch = YES;
        sharedView.position = LSHUDPOSITION_Center;
    });
#else
    dispatch_once(&once, ^{ sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
#endif
    return sharedView;
}
//设置是否可以被点击
+ (void)setBackViewWithClick:(BOOL)isTouch{
    [self sharedView].isTouch = isTouch;
    [self sharedView].backgroundView.userInteractionEnabled = isTouch;
}
//设置背景色
+ (void)setBackColor:(UIColor*)color{
   [self sharedView].backgroundView.backgroundColor = color;
    [self sharedView].isTouch = NO;
}
+(void)setStateColor:(UIColor *)color{
    [self sharedView].stateColor = color;
    [self sharedView].activityIndicatorView.tintColor = color;
}

+(void)setTitleLabelColor:(UIColor *)color{
    [self sharedView].titleColor = color;
}

+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval{
    [self sharedView].dismissTime = interval;
}
///设置展示的位置
+(void)setHudPosition:(LSHUDPOSITION)position{
    [self sharedView].position = position;
}
///自定义位置
+(void)setCustomHudPosition:(CGFloat)positionOffset{
//    if (positionOffset>0.0) {
        [self sharedView].positionOffset = positionOffset;
        [self sharedView].position = LSHUDPOSITION_Custom;
//    }
}
+(void)Show{
    [self _dismissAllView];
     [[self sharedView] _showWithTitle:@""];
    [self _isTouchShow];
}

+(void)ShowWithTitle:(NSString*)str{
    [self _dismissAllView];
    [[self sharedView] _showWithTitle:str];
    [self _isTouchShow];
}

+(void)_isTouchShow{
     [self sharedView].bgView.alpha = 1;
    if (![self sharedView].isTouch) {
           [[UIApplication sharedApplication].keyWindow addSubview:[self sharedView]];
        
       } else {
           [[self sharedView].controlView addSubview:[self sharedView]];
           [[self sharedView].frontWindow addSubview:[self sharedView].controlView];
       }
}

+(void)_dismissAllView{
    [self sharedView].titleLabel.text = @"";
    [[self sharedView].successView removeFromSuperview];
    [[self sharedView].failView removeFromSuperview];
    [[self sharedView].titleLabel removeFromSuperview];
    [[self sharedView].activityIndicatorView removeFromSuperview];
}

 

+(void)dismiss{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __block void (^animationsBlock)(void) = ^{
        [self sharedView].bgView.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            [self sharedView].bgView.alpha = 0;
        }completion:^(BOOL finished) {
            [[self sharedView] removeFromSuperview];
            UIViewController *rootController = [[UIApplication sharedApplication] keyWindow].rootViewController;
                [rootController setNeedsStatusBarAppearanceUpdate];
            }];
        };
        if (animationsBlock) {
            animationsBlock();
        }
    }];
}

+(void)dismissWithTimeInterval:(NSTimeInterval)interval{
    [self sharedView].dismissTime = interval;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismiss];
    });
}

+(void)ShowSuccessView{
    [self _dismissAllView];
    [self _isTouchShow];
    [[self sharedView] _setSuccessLable:@""];
    [self dismissWithTimeInterval:[self sharedView].dismissTime];
}

+(void)ShowFailView{
     [self _dismissAllView];
    [self _isTouchShow];
    [[self sharedView] _setFailLable:@""];
    [self dismissWithTimeInterval:[self sharedView].dismissTime];
}

+(void)ShowTitle:(NSString*)title{
     [self _dismissAllView];
    [[self sharedView] _setStateLable:title];
     [self _isTouchShow];
    [self dismissWithTimeInterval:[self sharedView].dismissTime];
}

+(void)ShowSuccessWithTitle:(NSString*)title{
    [self _dismissAllView];
    [[self sharedView] _setSuccessLable:title];
    [self _isTouchShow];
    [self dismissWithTimeInterval:[self sharedView].dismissTime];
}

+(void)ShowFailWithTitle:(NSString*)title{
    [self _dismissAllView];
    [[self sharedView] _setFailLable:title];
    [self _isTouchShow];
    [self dismissWithTimeInterval:[self sharedView].dismissTime];
}

- (void)setShadowLayer:(UIColor *)shadowColor shadowRadius:(CGFloat)radious view:(UIView *)view {
     view.layer.shadowOpacity = 1;
     view.layer.shadowOffset = CGSizeZero;
     view.layer.shadowColor = shadowColor.CGColor; //[UIColor greenColor].CGColor;
     view.layer.shadowRadius = radious;
     view.layer.cornerRadius = radious;
}
 

-(void)_showWithTitle:(NSString*)str{
   self.titleLabel.text = str;
    self.bgView.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.alpha = 1;
        [self.activityIndicatorView startAnimating];
        [self.bgView addSubview:self.activityIndicatorView];
        if (str.length==0) {
            [self _UpdataViewFrame:LSHUDTYPE_SHOW];
        } else {
          [self _UpdataViewFrame:LSHUDTYPE_LOADING];
        }
    }completion:^(BOOL finished) {
    }];
}
 

-(void)_setSuccessLable:(NSString *)str{
    self.titleLabel.text = str;
    [self.bgView addSubview:self.successView];
    [self.successView _updataView];
    [self _UpdataViewFrame:LSHUDTYPE_SUCCESS];
}

-(void)_setFailLable:(NSString*)str{
   self.titleLabel.text = str;
    [self.bgView addSubview:self.failView];
    [self.failView _updataView];
    [self _UpdataViewFrame:LSHUDTYPE_FAIL];
}
-(void)_setStateLable:(NSString*)str{
   self.titleLabel.text = str;
    [self _UpdataViewFrame:LSHUDTYPE_TITLE];
}

-(void)_UpdataViewFrame:(LSHUDTYPE)type{
    [self.bgView addSubview:self.titleLabel];
    CGFloat labelHeight = 0.0f;
    CGFloat labelWidth = 0.0f;
    if(self.titleLabel.text.length>0) {
        CGSize labelSize = [self.titleLabel sizeThatFits:CGSizeMake(200.f, MAXFLOAT)];
        labelHeight = ceil(labelSize.height)+1;
        labelWidth = ceil(labelSize.width);
    }else{
        labelWidth=40;
        labelHeight = 15;
    }
    [self.titleLabel sizeToFit];
    
    switch (self.position) {
        case LSHUDPOSITION_Top:
       {
           [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(self).offset(-self.bounds.size.height*0.3);
           }];
       }break;
        case LSHUDPOSITION_Center:
        {
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
            }];
        }break;
        case LSHUDPOSITION_Bottom:
        {
           [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.centerY.equalTo(self).offset(self.bounds.size.height*0.3);
           }];
        }break;
        case LSHUDPOSITION_Custom:
        {
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {  make.centerY.equalTo(self).offset(self.bounds.size.height*self.positionOffset);
            }];
        }break;
    }
    
    switch (type) {
        case LSHUDTYPE_SHOW:
        {
           [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(100, 100));
            }];
            [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.bgView);
                make.size.mas_offset(CGSizeMake(50, 50));
            }];
        } break;
        case LSHUDTYPE_SUCCESS:
        {
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(labelWidth+60>100?labelWidth+60:100, labelHeight+85));
                make.height.lessThanOrEqualTo(@400);
            }];
            [self.successView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(self.titleLabel.text.length>0?15:25);
                make.centerX.mas_offset(0);
                make.size.mas_offset(CGSizeMake(50, 50));
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.successView.mas_bottom).offset(10);
                make.left.mas_offset(15);
                make.right.mas_offset(-15);
                make.bottom.mas_offset(-10);
            }];
        }break;
        case LSHUDTYPE_FAIL:
        {
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(labelWidth+60>100?labelWidth+60:100, labelHeight+85));
                make.height.lessThanOrEqualTo(@400);
            }];
           [self.failView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(self.titleLabel.text.length>0?15:25);
                make.centerX.mas_offset(0);
                make.size.mas_offset(CGSizeMake(50, 50));
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.failView.mas_bottom).offset(10);
                make.left.mas_offset(15);
                make.right.mas_offset(-15);
                make.bottom.mas_offset(-10);
            }];
        } break;
        case LSHUDTYPE_TITLE:
        {
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_offset(CGSizeMake(labelWidth+60, labelHeight+20));
                make.height.lessThanOrEqualTo(@400);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.bgView).offset(10);
                make.left.mas_offset(15);
                make.right.mas_offset(-15);
                make.bottom.mas_offset(-10);
            }];
        } break;
        case LSHUDTYPE_LOADING:
       {
           [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
               make.size.mas_offset(CGSizeMake(labelWidth+60, labelHeight+85));
           }];
           [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.mas_offset(self.titleLabel.text.length>0?15:25);
               make.centerX.mas_offset(0);
               make.size.mas_offset(CGSizeMake(50, 50));
           }];
           [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
               make.top.equalTo(self.activityIndicatorView.mas_bottom).offset(10);
               make.left.mas_offset(15);
               make.right.mas_offset(-15);
               make.bottom.mas_offset(-10);
           }];
       } break;
    }
}

- (void)controlViewDidReceiveTouchEvent:(id)sender forEvent:(UIEvent*)event {
 
}

 -(UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        BOOL windowKeyWindow = window.isKeyWindow;
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported && windowKeyWindow) {
            return window;
        }
    }
#endif
    return nil;
}

-(UIView*)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:self.frame];
       _backgroundView.backgroundColor = [UIColor clearColor];
        _backgroundView.userInteractionEnabled = NO;
       [self addSubview:_backgroundView];
    }
    return _backgroundView;
}

-(UIView*)bgView{
    if (!_bgView) {
        self.isAccessibilityElement = YES;
       _bgView = [[UIView alloc]initWithFrame:CGRectMake( (LSW / 2) - 50 , (LSH / 2) - 50 ,100, 100)];
        _bgView.backgroundColor  = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
        [self.backgroundView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_offset(0);
            make.size.mas_offset(CGSizeMake(100, 100));
        }];
        [self setShadowLayer:[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1] shadowRadius:10 view:_bgView];
    }
    return _bgView;
}

-(DGActivityIndicatorView*)activityIndicatorView{
    if (!_activityIndicatorView) {
        UIColor *color = [UIColor colorWithRed:52/255.0 green:211/255.0 blue:228/255.0 alpha:1];
      _activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:color size:40];
       _activityIndicatorView.frame =  CGRectMake((100 - 50 )/2, (100 - 50 )/2, 50, 50);
        [self.bgView addSubview:_activityIndicatorView];
    }
    return _activityIndicatorView;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

-(LSSuccessView*)successView{
    if(!_successView){
        _successView = [[LSSuccessView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _successView.center = self.bgView.center;
    }
    return _successView;
}

-(LSFailView *)failView{
    if (!_failView) {
        _failView = [[LSFailView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _failView.center = self.bgView.center;
    }
    
    return _failView;
}
- (UIControl*)controlView {
    if(!_controlView) {
        _controlView = [UIControl new];
        _controlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _controlView.backgroundColor = [UIColor clearColor];
        _controlView.userInteractionEnabled = NO;
        [_controlView addTarget:self action:@selector(controlViewDidReceiveTouchEvent:forEvent:) forControlEvents:UIControlEventTouchDown];
    }
    
    // Update frames
#if !defined(SV_APP_EXTENSIONS)
    CGRect windowBounds = [[[UIApplication sharedApplication] delegate] window].bounds;
    _controlView.frame = windowBounds;
#else
    _controlView.frame = [UIScreen mainScreen].bounds;
#endif
    
    return _controlView;
}

 

@end
