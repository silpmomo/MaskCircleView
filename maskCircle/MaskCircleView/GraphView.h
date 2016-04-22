//
//  GraphView.h
//  maskCircle
//
//  Created by KimDaeCheol on 2016. 4. 4..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//가로 비율을 50등분 합니다.
#define widthDivision 50
#define heightDivision 100
@interface GraphView : UIView
{
    NSMutableArray *shapeArray;
}
-(void)drawGraphPointArray:(NSArray*)array ShapeTag:(NSInteger)tag;
-(CAShapeLayer *)addLineSapeLayer:(UIColor*)color FillColor:(UIColor*)fillColor LineWidth:(CGFloat)width Tag:(NSInteger)tag;
-(void)createPieRound:(UIColor*)color FillColor:(UIColor*)fillColor LineWidth:(CGFloat)width startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle Radius:(CGFloat)radius Tag:(NSInteger)tag;
-(void)pieRoundDraw:(CGFloat)startAngle endAngle:(CGFloat)endAngle Tag:(NSInteger)tag;
-(void)pieRoundDraw:(CGFloat)startAngle endAngle:(CGFloat)endAngle Radius:(CGFloat)radius Tag:(NSInteger)tag;
@end
