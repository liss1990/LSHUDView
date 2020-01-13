//
//  LSSuccessView.m
//  Demo
//
//  Created by Ebuy EDITSUITE MAC on 2020/1/4.
//  Copyright © 2020 Lisisi. All rights reserved.
//

#import "LSSuccessView.h"

 
@interface LSSuccessView()
@property(nonatomic,strong)UIView *bgView;

@end

@implementation LSSuccessView
 

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.strokeColor = [UIColor colorWithRed:52/255.0 green:211/255.0 blue:228/255.0 alpha:1];
        [self drawSuccessLine:frame];
    }
    return self;
}
-(void)_updataView{
    [self drawSuccessLine:CGRectMake(0, 0, 50, 50)];
}
- (void)drawSuccessLine:(CGRect)frame{

     [self.bgView removeFromSuperview];
     self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height)];
   
     UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(frame.size.width/2, frame.size.height/2) radius:frame.size.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
     //对拐角和中点处理
     path.lineCapStyle  = kCGLineCapRound;
     path.lineJoinStyle = kCGLineJoinRound;

     //对号第一部分直线的起始
     [path moveToPoint:CGPointMake(frame.size.width/5-1.5, frame.size.width/2)];
     CGPoint p1 = CGPointMake(frame.size.width/5.0*2, frame.size.width/4.0*3);
     [path addLineToPoint:p1];

     //对号第二部分起始
     CGPoint p2 = CGPointMake(frame.size.width/8.0*7,frame.size.width/4.0+6);
     [path addLineToPoint:p2];

     CAShapeLayer *layer = [[CAShapeLayer alloc] init];
     //内部填充颜色
     layer.fillColor = [UIColor clearColor].CGColor;
     //线条颜色
    layer.strokeColor = self.strokeColor.CGColor;
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

     [self.bgView.layer addSublayer:layer];
     [self addSubview:self.bgView];
 }

@end
