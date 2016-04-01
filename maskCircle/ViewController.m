//
//  ViewController.m
//  maskCircle
//
//  Created by silpmomo on 2016. 4. 1..
//  Copyright © 2016년 silpmomo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize maskCircleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [maskCircleView setImage:[UIImage imageNamed:@"img_percent_blue"]];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(spinit:) userInfo:nil repeats:YES];
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

@end
