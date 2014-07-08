//
//  ColoredBezierPath.m
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import "ColoredBezierPath.h"

@implementation ColoredBezierPath

- (id)initWithColor:(UIColor *)color
{
    self = [super init];
    
    if(self)
    {
        _color = color;
    }
    
    return self;
}

@end

