//
//  DrawingView.m
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        _paths = [[NSMutableArray alloc] init];
        _pathColor = [UIColor blueColor];
        _pathWidth = 5;
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    for(NSInteger i = 0; i <_paths.count; i++)
    {
        //get a reference to the UIBezierPath object at index "i"
        ColoredBezierPath *path = [_paths objectAtIndex:i];
        
        //this let's iOS know that strokes should be made with this color
        [path.color setStroke];
        
        //draw the path in this DrawingView
        [path stroke];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get a reference to any one of the user's touches
    UITouch *touch = [touches anyObject];
    
    //convert the user's touch to an (x,y) coordinate
    CGPoint point = [touch locationInView:self];
    
    //create a new path for the current path
    _currentPath = [[ColoredBezierPath alloc] initWithColor:_pathColor];
    [_currentPath setLineWidth:_pathWidth];
    
    [_paths addObject:_currentPath];
    
    //move the current path to the point we extracted earlier
    [_currentPath moveToPoint:point];
    
    //let iOS know that we need to call the drawRect method again
    //this will refresh the view so that the most up-to-date paths are drawn
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get a reference to any one of the user's touches
    UITouch *touch = [touches anyObject];
    
    //convert the user's touch to an (x,y) coordinate
    CGPoint point = [touch locationInView:self];
    
    //add a straight line to the point we just extracted
    [_currentPath addLineToPoint:point];
    
    //refresh the drawn points
    [self setNeedsDisplay];
}

-(void)clear
{
    [UIView animateWithDuration:.3
     //make the view go invisible over the course of 0.3 seconds
                     animations:^{[self setAlpha:0];}
                     completion:^(BOOL finished){
                         //after the view has completed its animation
                         //remove all paths from the _paths array, then refresh the veiw
                         [_paths removeAllObjects];
                         [self setNeedsDisplay];
                         //make the view visible again
                         [self setAlpha:1];
                     }];
}

@end
