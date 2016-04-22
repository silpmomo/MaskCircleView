//
//  ViewController.h
//  maskCircle
//
//  Created by KimDaeCheol on 2016. 4. 1..
//  Copyright © 2016년 KimDaeCheol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaskCircleView.h"
#import "GraphView.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MaskCircleView *maskCircleView;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@end

