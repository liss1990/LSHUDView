//
//  LSSuccessView.m
//  Demo
//
//  Created by Ebuy EDITSUITE MAC on 2020/1/4.
//  Copyright © 2020 Lisisi. All rights reserved.
//

#import "LSSuccessView.h"

 


@implementation LSSuccessView
{
    UIView *bgView;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self drawSuccessLine];

    }
    return self;
}
 - (void)drawSuccessLine{

     [bgView removeFromSuperview];
     bgView = [[UIView alloc] initWithFrame:self.frame];
   
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.center.x, self.center.y) radius:self.frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
     //对拐角和中点处理
     path.lineCapStyle  = kCGLineCapRound;
     path.lineJoinStyle = kCGLineJoinRound;

     //对号第一部分直线的起始
     [path moveToPoint:CGPointMake(self.frame.size.width/5-1.5, self.frame.size.width/2)];
     CGPoint p1 = CGPointMake(self.frame.size.width/5.0*2, self.frame.size.width/4.0*3);
     [path addLineToPoint:p1];

     //对号第二部分起始
     CGPoint p2 = CGPointMake(self.frame.size.width/8.0*7, self.frame.size.width/4.0+6);
     [path addLineToPoint:p2];

     CAShapeLayer *layer = [[CAShapeLayer alloc] init];
     //内部填充颜色
     layer.fillColor = [UIColor clearColor].CGColor;
     //线条颜色
     layer.strokeColor = [UIColor colorWithRed:52/255.0 green:211/255.0 blue:228/255.0 alpha:1].CGColor;
     //线条宽度
     layer.lineWidth = 3;
     layer.path = path.CGPath;
     layer.lineCap = kCALineCapRound;
     
 //动画设置
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
     animation.fromValue = @0;
     animation.toValue = @1;
     animation.duration = 0.5;
     [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];

     [bgView.layer addSublayer:layer];
     [self addSubview:bgView];
 }

@end
