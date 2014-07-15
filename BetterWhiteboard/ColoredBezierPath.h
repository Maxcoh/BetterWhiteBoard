//
//  ColoredBezierPath.h
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColoredBezierPath : UIBezierPath

@property (strong, nonatomic) UIColor *color;

- (id)initWithColor:(UIColor *)color;
@end
