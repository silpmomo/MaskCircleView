//
//  ViewController.m
//  maskCircle
//
//  Created by silpmomo on 2016. 4. 1..
//  Copyright © 2016년 silpmomo. All rights reserved.
//

#define redLineTag 10

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize maskCircleView,graphView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [maskCircleView setImage:[UIImage imageNamed:@"img_percent_blue"]];
    [graphView addLineSapeLayer:[UIColor redColor] FillColor:[UIColor clearColor] LineWidth:2 Tag:redLineTag];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
//    [maskCircleView setProgress:1.0 animated:YES];
    NSArray *sample = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 10)],
                       [NSValue valueWithCGPoint:CGPointMake(20, 20)],
                       [NSValue valueWithCGPoint:CGPointMake(40, 5)],
                       [NSValue valueWithCGPoint:CGPointMake(60, 30)],
                       [NSValue valueWithCGPoint:CGPointMake(70, 5)],
                       [NSValue valueWithCGPoint:CGPointMake(80, 10)],
                       [NSValue valueWithCGPoint:CGPointMake(90, 35)],
                       [NSValue valueWithCGPoint:CGPointMake(100, 40)],
                       [NSValue valueWithCGPoint:CGPointMake(100, 30)],nil];
    [graphView drawGraphPointArray:sample ShapeTag:redLineTag];
//    [graphView createPieRound:[UIColor clearColor] FillColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"test1"]] LineWidth:8 startAngle:0 endAngle:250 Tag:1000];
}
- (void)viewDidAppear:(BOOL)animated
{
//    [maskCircleView setProgress:1.0 animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)spinit:(NSTimer *)timer
{
    static float prog = 0.0;
    prog += 0.01;
    if(prog >= 1.0) {
        prog = 1.0;
        [timer invalidate];
    }
    [maskCircleView setProgress:prog animated:YES];
}

- (IBAction)onSlideTounup:(UISlider *)sender {
    [maskCircleView setProgress:sender.value animated:YES];
}
- (IBAction)onSliderChange:(UISlider*)slider {
}
@end
