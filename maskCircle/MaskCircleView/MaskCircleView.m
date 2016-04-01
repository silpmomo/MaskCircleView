//
//  MaskCircleView.m
//  maskCircle
//
//  Created by silpmomo on 2016. 4. 1..
//  Copyright © 2016년 silpmomo. All rights reserved.
//
/*
 <사용법>
 progress 0~1.0까지
 mask를 부채꼴 모양으로 돌려서 표현하는 방법이므로
 setimage는 필수.
 setprogress:animated함수로 사용.
 
 ex)
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 [[self maskCircleView] setImage:[UIImage imageNamed:@"circleblue.png"]];
 
 [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
 
 }
 - (void)spinit:(NSTimer *)timer
 {
 static float prog = 0.0;
 prog += 0.01;
 if(prog >= 1.0) {
 prog = 1.0;
 [timer invalidate];
 }
 [[self maskCircleView] setProgress:prog animated:YES];
 }
 */

#import "MaskCircleView.h"
#import <QuartzCore/QuartzCore.h>

@interface MaskCircleView()

@property (nonatomic) float progress;
@property (nonatomic, assign) CALayer *bgLayer;//이미지 레이어
@property (nonatomic, assign) CAShapeLayer *maskLayer;//마스크 레이어

@end

@implementation MaskCircleView

-(void)commonInit{
    CALayer *l = [CALayer layer];
    [[self layer] addSublayer:l];
    [self setBgLayer:l];
    
    CAShapeLayer *m = [CAShapeLayer layer];
    [[self bgLayer] setMask:m];
    [self setMaskLayer:m];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    return self;
}
- (void)setImage:(UIImage *)image
{
    [[self bgLayer] setContents:(id)[image CGImage]];
}
- (void)setProgress:(float)progress animated:(BOOL)animated
{
    float currentProgress = _progress;
    _progress = progress;
    CGRect bounds = [self bounds];
    [CATransaction begin];
    if(animated) {
        float delta = fabs(_progress - currentProgress);
        [CATransaction setAnimationDuration:MAX(0.2, delta * 1.0)];
    } else {
        [CATransaction setDisableActions:YES];
    }
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:CGPointMake(bounds.size.width/2, bounds.size.height/2)];
    
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(bounds.size.width/2, 0)];
    //사등분씩 가장 위쪽 기준으로 3pi/2 -> 0 or 2pi -> pi/2 -> pi
    //원형 프로그래스바를 그리기 위해선 0일때 가장 최상단부터 시작해야 하므로 -m_pi_2부터 시작해야함.
    [aPath addArcWithCenter:CGPointMake(bounds.size.width/2, bounds.size.height/2) radius:[self radius] startAngle:-M_PI_2 endAngle:M_PI*2*_progress-M_PI_2 clockwise:YES];
    [aPath closePath];
    self.maskLayer.path = aPath.CGPath;
    [CATransaction commit];
}
- (void)setProgress:(float)progress
{
    [self setProgress:progress animated:NO];
}
- (float)radius
{
    CGRect rect = [self bounds];
    
    float width = rect.size.width;
    float height = rect.size.height;
    
    if(width > height)
        return height / 2.0;
    return width / 2.0;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];
    [[self bgLayer] setFrame:bounds];
    [[self maskLayer] setFrame:bounds];
}

@end
