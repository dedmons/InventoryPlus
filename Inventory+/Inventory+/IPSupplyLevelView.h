//
//  IPSupplyLevelView.h
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPSupplyLevelView : UIView

@property (nonatomic, assign) NSInteger maxAmmount;
@property (nonatomic, assign) NSInteger desiredAmmount;
@property (nonatomic, assign) NSInteger alertAmmount;
@property (nonatomic, assign) NSInteger currentAmmount;

-(id)initWithFrame:(CGRect)frame Max:(NSInteger)m Desired:(NSInteger)d AndAlert:(NSInteger)a;

@end
