//
//  IPSupplyLevelView.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPSupplyLevelView.h"

@interface IPSupplyLevelView ()

@property (nonatomic, assign) CGFloat currentValue;
@property (nonatomic, assign) CGFloat step;

@end

@implementation IPSupplyLevelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxAmmount = 0;
        self.desiredAmmount = 0;
        self.alertAmmount = 0;
        self.currentAmmount = 0;
        self.currentValue = 0.0;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Max:(NSInteger)m Desired:(NSInteger)d AndAlert:(NSInteger)a{
    self = [self initWithFrame:frame];
    if (self) {
        self.maxAmmount = m;
        self.desiredAmmount = d;
        self.alertAmmount = a;
    }
    return self;
}

- (void)setMaxAmmount:(NSInteger)maxAmmount{
    if(maxAmmount != _maxAmmount && maxAmmount >= 0){
        _maxAmmount = maxAmmount;
        [self setNeedsDisplay];
    }
}

- (void)setDesiredAmmount:(NSInteger)desiredAmmount{
    if(desiredAmmount != _desiredAmmount && desiredAmmount >= 0){
        _desiredAmmount = desiredAmmount;
        [self setNeedsDisplay];
    }
}

- (void)setAlertAmmount:(NSInteger)alertAmmount {
    if (alertAmmount != _alertAmmount && alertAmmount >= 0) {
        _alertAmmount = alertAmmount;
        [self setNeedsDisplay];
    }
}

- (void)setCurrentAmmount:(NSInteger)currentAmmount {
    if (currentAmmount != _currentAmmount && currentAmmount >= 0) {
        self.step = abs(_currentAmmount - currentAmmount)/100.0;
        _currentAmmount = currentAmmount;
        [self setNeedsDisplay];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"Drawing A:%d V:%f ",self.currentAmmount,self.currentValue);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat boxWidth = self.bounds.size.width;
    CGFloat boxHeight = self.bounds.size.height;
    CGFloat barHeight = boxHeight * ((self.currentValue * 1.0)/(self.maxAmmount * 1.0));
    CGFloat alertHeight = boxHeight * ((self.alertAmmount * 1.0)/(self.maxAmmount * 1.0));
    CGFloat desiredHeight = boxHeight * ((self.desiredAmmount * 1.0)/(self.maxAmmount * 1.0));
    
    if (self.currentValue < self.alertAmmount || self.currentAmmount > self.maxAmmount) {
        [[UIColor redColor] set];
    } else if (self.currentValue < self.desiredAmmount) {
        [[UIColor yellowColor] set];
    } else {
        [[UIColor greenColor] set];
    }
    
    CGRect bar = CGRectMake(0, boxHeight-barHeight, boxWidth, barHeight);
    
    CGContextFillRect(context, bar);
    
    [[UIColor blackColor] set];
    
    CGRect box = CGRectMake(0, 0, boxWidth, boxHeight);
    CGContextStrokeRectWithWidth(context, box, 2.0);
    box.size.height = boxHeight-desiredHeight;
    CGContextStrokeRectWithWidth(context, box, 2.0);
    box.size.height = boxHeight-alertHeight;
    CGContextStrokeRectWithWidth(context, box, 2.0);
    
    
    NSString *s = @"Low";
    CGPoint p = CGPointMake(4, boxHeight-alertHeight+6);
    [s drawAtPoint:p
          forWidth:boxWidth-4
          withFont:[UIFont systemFontOfSize:9]
          fontSize:12
     lineBreakMode:UILineBreakModeCharacterWrap
baselineAdjustment:UIBaselineAdjustmentNone];
    
    s = @"Max";
    if ( abs(p.y - 6) > 10) {
        NSLog(@"Max");
        p.y = 6;
        [s drawAtPoint:p
              forWidth:boxWidth-4
              withFont:[UIFont systemFontOfSize:9]
              fontSize:12
         lineBreakMode:UILineBreakModeCharacterWrap
    baselineAdjustment:UIBaselineAdjustmentNone];
    }
    
    s = @"Normal";
    if ( abs(p.y - boxHeight-desiredHeight+6) > 10) {
        NSLog(@"Norm");
        p.y = boxHeight-desiredHeight+6;
        [s drawAtPoint:p
              forWidth:boxWidth-4
              withFont:[UIFont systemFontOfSize:9]
              fontSize:12
         lineBreakMode:UILineBreakModeCharacterWrap
    baselineAdjustment:UIBaselineAdjustmentNone];
    }
    
    if (self.currentValue < self.currentAmmount-self.step && self.currentValue < self.maxAmmount) {
        self.currentValue += self.step;
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.0];
    }
    else if (self.currentValue > self.currentAmmount+self.step) {
        self.currentValue -= self.step;
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0.0];
    }
}


@end
