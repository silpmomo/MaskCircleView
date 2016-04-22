//
//  GraphView.m
//  maskCircle
//
//  Created by KimDaeCheol on 2016. 4. 4..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//
//  현재 공간의 100분율로 x,y좌표 구현되어져 있으며 좌표또한 100분율 기준으로 cgpoint를 생성해서 넘겨야 한다.
//  array는 nsvalue로 저장된다.

#import "GraphView.h"
//가로 10개로 분할.
#define Division 50
#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
#define radiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )
@implementation GraphView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (float)radius
{
    CGRect r = [self bounds];
    float w = r.size.width;
    float h = r.size.height;
    if(w > h)
        return h / 2.0;
    
    return w / 2.0;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
    }
    return self;
}
-(UIBezierPath*)createBezierPath:(CGFloat)startAngle endAngle:(CGFloat)endAngle Radius:(CGFloat)radius{
    CGFloat rs_angle = degreesToRadians(startAngle-90);
    CGFloat re_angle = degreesToRadians(endAngle-90);
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    if(radius==-1)
        radius = [self radius];
    UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:center];
    
    [piePath addLineToPoint:CGPointMake(center.x + radius * cosf(rs_angle), center.y + radius * sinf(rs_angle))];
    
    [piePath addArcWithCenter:center radius:radius startAngle:rs_angle endAngle:re_angle clockwise:YES];
    
    //   [piePath addLineToPoint:center];
    [piePath closePath]; // this will automatically add a straight line to the center
    
    return piePath;
}
-(void)createPieRound:(UIColor*)color FillColor:(UIColor*)fillColor LineWidth:(CGFloat)width startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle Radius:(CGFloat)radius Tag:(NSInteger)tag {
    CAShapeLayer *layer = [self addLineSapeLayer:color FillColor:fillColor LineWidth:width Tag:tag];
    [layer setPath:[[self createBezierPath:startAngle endAngle:endAngle Radius:radius] CGPath]];
    [self.layer addSublayer:layer];
}
-(void)pieRoundDraw:(CGFloat)startAngle endAngle:(CGFloat)endAngle Tag:(NSInteger)tag{
    CAShapeLayer *layer = NULL;
    for(NSDictionary *item in shapeArray){
        NSInteger mtag = [[item valueForKey:@"tag"] intValue];
        if(mtag==tag){
            //동일 레이어
            layer=(CAShapeLayer*)[item valueForKey:@"layer"];
            //NSLog(@"동일 레이어%@",layer);
            break;
        }
    }
    [layer setPath:[[self createBezierPath:startAngle endAngle:endAngle Radius:-1] CGPath]];
}
-(void)pieRoundDraw:(CGFloat)startAngle endAngle:(CGFloat)endAngle Radius:(CGFloat)radius Tag:(NSInteger)tag{
    CAShapeLayer *layer = NULL;
    for(NSDictionary *item in shapeArray){
        NSInteger mtag = [[item valueForKey:@"tag"] intValue];
        if(mtag==tag){
            //동일 레이어
            layer=(CAShapeLayer*)[item valueForKey:@"layer"];
            //NSLog(@"동일 레이어%@",layer);
            break;
        }
    }
    [layer setPath:[[self createBezierPath:startAngle endAngle:endAngle Radius:radius] CGPath]];
}
-(void)drawGraphPointArray:(NSArray*)array ShapeTag:(NSInteger)tag{
    CAShapeLayer *layer = NULL;
    for(NSDictionary *item in shapeArray){
        NSInteger mtag = [[item valueForKey:@"tag"] intValue];
        if(mtag==tag){
            //동일 레이어
            layer=(CAShapeLayer*)[item valueForKey:@"layer"];
            //NSLog(@"동일 레이어%@",layer);
            break;
        }
    }
    int count = 0;
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    CGRect bounds = self.bounds;
    //    //CGFloat width_rate = bounds.size.width/100;
    //    CGFloat height_rate = bounds.size.height/heightDivision;
    CGFloat width = bounds.size.width/widthDivision;
    //NSLog(@"%f,%f",width_rate,height_rate);
    CGPoint pre_p=CGPointMake(0, 0);
    for(NSValue *item in array){
        CGPoint point = [item CGPointValue];
        CGPoint p = CGPointMake(width*count, round(point.y*bounds.size.height)/100);
        if(pre_p.x!=0){
            CGFloat dive = p.y-pre_p.y;
            if((dive>=0.03&&dive<=0.1)||(dive<=-0.03&&dive>=-0.1)){
                dive*=30;
            }
            pre_p=p;
            p.y+=dive;
            if(p.y<=0||p.y>=bounds.size.height){
                p.y-=dive;
            }
        }else{
            pre_p=p;
        }
        if(count==0)
            [aPath moveToPoint:p];
        else
            [aPath addLineToPoint:p];
        count++;
    }
    [layer setPath:[aPath CGPath]];
}
-(CAShapeLayer *)addLineSapeLayer:(UIColor*)color FillColor:(UIColor*)fillColor LineWidth:(CGFloat)width Tag:(NSInteger)tag{
    CAShapeLayer* item = [CAShapeLayer layer];
    [item setStrokeColor:[color CGColor]];
    [item setFillColor:[fillColor CGColor]];
    [item setLineWidth:width];//라인두께 정하기
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:item,@"layer",[NSNumber numberWithInteger:tag],@"tag", nil];
    if(shapeArray==nil)
        shapeArray=[[NSMutableArray alloc] init];
    [shapeArray addObject:dic];
    [self.layer addSublayer:item];
    return item;
}

@end
