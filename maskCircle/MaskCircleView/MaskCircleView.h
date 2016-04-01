//
//  MaskCircleView.h
//  maskCircle
//
//  Created by silpmomo on 2016. 4. 1..
//  Copyright © 2016년 silpmomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskCircleView : UIView
-(void)setImage:(UIImage *)image;
-(void)setProgress:(float)progress animated:(BOOL)animated;
-(void)commonInit;
@end
