//
//  DPActivityIndicatorView.m
//  DeliveryProject
//
//  Created by 罗向宇 on 2016/10/23.
//  Copyright © 2016年 罗向宇. All rights reserved.
//

#import "DPActivityIndicatorView.h"
#import "UIColor+DPTheme.h"

@implementation DPActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpIndicatorView];
    }
    return self;
}

- (void)setUpIndicatorView
{
    [self setupAnimationInLayer:self.layer withSize:self.frame.size tintColor:[UIColor dp_radicalRedColor]];
}

- (void)setupAnimationInLayer:(CALayer *)layer withSize:(CGSize)size tintColor:(UIColor *)tintColor
{
    CGFloat circleSpacing = -2;
    CGFloat circleSize = (size.width - 4 * circleSpacing) / 5;
    CGFloat x = (layer.bounds.size.width - size.width) / 2;
    CGFloat y = (layer.bounds.size.height - size.height) / 2;
    CFTimeInterval duration = 1;
    CFTimeInterval beginTime = CACurrentMediaTime();
    NSArray *beginTimes = @[ @0, @0.12, @0.24, @0.36, @0.48, @0.6, @0.72, @0.84 ];

    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.keyTimes = @[ @0, @0.5, @1 ];
    scaleAnimation.values = @[ @1.0, @0.4, @1.0 ];
    scaleAnimation.duration = duration;

    // Opacity animation
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.keyTimes = @[ @0, @0.5, @1 ];
    opacityAnimation.values = @[ @1, @0.3, @1 ];
    opacityAnimation.duration = duration;

    // Animation
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    animation.animations = @[ scaleAnimation, opacityAnimation ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = duration;
    animation.repeatCount = HUGE;
    animation.removedOnCompletion = false;

    // Draw circles
    for (int i = 0; i < 8; i++) {
        CALayer *circle = [self circleAt:(CGFloat)(M_PI_4 * (double)i) withSize:circleSize origin:CGPointMake(x, y) containerSize:size color:tintColor];
        animation.beginTime = beginTime + [beginTimes[i] floatValue];
        [circle addAnimation:animation forKey:@"animation"];
        [layer addSublayer:circle];
    }
}

- (CALayer *)circleAt:(CGFloat)angle withSize:(CGFloat)size origin:(CGPoint)origin containerSize:(CGSize)containerSize color:(UIColor *)color
{
    CGFloat radius = containerSize.width / 2 - size;

    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGSize pathSize = CGSizeMake(size, size);

    [path addArcWithCenter:CGPointMake(pathSize.width / 2, pathSize.height / 2) radius:(pathSize.width / 2) startAngle:0 endAngle:(CGFloat)(2 * M_PI) clockwise:false];
    layer.fillColor = color.CGColor;
    layer.backgroundColor = nil;
    layer.path = path.CGPath;

    CALayer *circle = layer;

    circle.frame = CGRectMake(origin.x + (radius + size / 2) * (cos(angle) + 1), origin.y + (radius + size / 2) * (sin(angle) + 1), size, size);
    
    return circle;
}

@end
