//
//  insertOTP.m
//  TelkomXsight
//
//  Created by Arie Andrian on 11/02/18.
//  Copyright © 2018 Arie Andrian. All rights reserved.
//

#import "insertOTP.h"

@implementation insertOTP

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    UIGestureRecognizer *rec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stopTap)];
    [self addGestureRecognizer:rec];
    return self;
}

-(void)showInView:(UIView*)view {
    [view addSubview:self];
    CGRect rect = self.frame;
    rect.origin.y = view.frame.size.height;
    self.frame = rect;
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect rect = self.frame;
        rect.origin.y = view.frame.size.height/3 - rect.size.height/2;
        self.frame = rect;
    } completion:nil];
    
}
-(void)dismiss {
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect rect = self.frame;
        rect.origin.y += rect.size.height*4;
        self.frame = rect;
    } completion:nil];
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {\
    [self removeFromSuperview];
}
-(void)stopTap {
    
}

@end
