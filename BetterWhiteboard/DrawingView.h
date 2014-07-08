//
//  DrawingView.h
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColoredBezierPath.h"

@interface DrawingView : UIView

//an array to hold all paths that should be drawn to the view
@property (strong, nonatomic) NSMutableArray *paths;

@property (strong, nonatomic)NSString *title;

@property (nonatomic) NSInteger pathWidth;

//the current path that is being drawn
@property (strong, nonatomic) ColoredBezierPath *currentPath;

//the color that the current path should be
@property (strong, nonatomic) UIColor *pathColor;

//remove all paths from the _paths array and clear the view
-(void)clear;

@end