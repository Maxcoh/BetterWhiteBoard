//
//  ViewController.m
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad
{
    
    NSURL *soundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"rick" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) soundURL, &playSoundID);
    
    
    [super viewDidLoad];
    //fills array with names of all colors available, for labels in picker view
    self.tags = [[NSArray alloc] initWithObjects:@"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Indigo", @"Violet", @"Gray", @"Black", @"Pink", @"Brown", nil];
    
    //populates colors array with UIColor objects accompanying the names above, same index
    self.colors = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor orangeColor], [UIColor colorWithRed:(233.0/225.0) green:(226.0/255.0) blue:(22.0/255.0) alpha:1], [UIColor colorWithRed:(87.0/255.0) green:(201.0/255.0) blue:(21.0/255.0) alpha:1], [UIColor blueColor], [UIColor colorWithRed:(75.0/255.0) green:(0.0/255.0) blue:(130.0/255.0) alpha:1], [UIColor purpleColor], [UIColor grayColor], [UIColor blackColor], [UIColor colorWithRed:(255.0/255.0) green:(105.0/255.0) blue:(180.0/255.0) alpha:1], [UIColor brownColor], nil];
    
    //rotates picker view so that it is horizontal instead of vertical
    self.picker.showsSelectionIndicator =YES;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [self.picker setTransform:rotate];
    
    //sets pickerview to start at the middle index of its objects
    [self.picker selectRow:((self.tags.count)/2) inComponent:0 animated:NO];
    
    //sets patchcolor equal to color selected by picker at start of app
    [_drawView setPathColor:[self.colors objectAtIndex:(self.tags.count/2)]];
    
}


//makes the title of the rows in pickerview the object at that index of
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.tags objectAtIndex:row];
}


//sets the iew for each individual row in picker view.  Makes a rectange, rotates it to be vertical, sets
//text to the objects in tags, set color to corresponding object in colors array
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, 120, 80);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [label setTransform:rotate];
    label.text = [self.tags objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:22.0];
    label.textColor = [_colors objectAtIndex:row];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 2;
    label.clipsToBounds = YES;
    return label ;
}

//number of rows in picker equal to number of colors available
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tags.count;
}

//only one "Wheel" for picker

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

//sets color of paths equal to object in colors array based on corresponding row selected in picker
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch(row)
    {
        case(0):
            [_drawView setPathColor:[_colors objectAtIndex:0]];
            break;
        case(1):
            [_drawView setPathColor:[_colors objectAtIndex:1]];
            break;
        case(2):
            [_drawView setPathColor:[_colors objectAtIndex:2]];
            break;
        case(3):
            [_drawView setPathColor:[_colors objectAtIndex:3]];
            break;
        case(4):
            [_drawView setPathColor:[_colors objectAtIndex:4]];
            break;
        case(5):
            [_drawView setPathColor:[_colors objectAtIndex:5]];
            break;
        case(6):
            [_drawView setPathColor:[_colors objectAtIndex:6]];
            break;
        case(7):
            [_drawView setPathColor:[_colors objectAtIndex:7]];
            break;
        case(8):
            [_drawView setPathColor:[_colors objectAtIndex:8]];
            break;
        case(9):
            [_drawView setPathColor:[_colors objectAtIndex:9]];
            break;
        case(10):
            [_drawView setPathColor:[_colors objectAtIndex:10]];
            break;
    }
}


//called when a motion ends
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //confirms that the motion is a shaking of the iphone
    if(motion == UIEventSubtypeMotionShake)
    {
        //calls the clear method when the shaking ends
        [_drawView clear];
    }
}


//sets height of each row in picker
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25.0;
}


- (IBAction)rickAndMorty:(id)sender
{
    AudioServicesPlaySystemSound(playSoundID);
    
}

//this action is linked to eraser button, draws white on top of frame
- (IBAction)changePathColor:(UIButton *)sender
{
    [_drawView setPathColor:[UIColor whiteColor]];
}

//sets sizew of stroke to
- (IBAction)changeSize:(UISlider *)sender
{
    _drawView.pathWidth = sender.value;
}

//removes last path in the path array
- (IBAction)undo:(id)sender
{
    //removes last path from _paths
    [_drawView.paths removeLastObject];
    //refreshes the view
    [_drawView setNeedsDisplay];
}

//saves contents of drawview to photo library
- (IBAction)save:(id)sender
{
    UIGraphicsBeginImageContext(_drawView.bounds.size);
    [_drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
}

//camera button functionality
- (IBAction)cameraPressed:(id)sender
{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload a picture" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Take a photo", @"Choose existing", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}

//allows user to either take a picture or pick an existing picture to set as background

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:NULL];
    }
    if(buttonIndex == 2){
        UIImagePickerController *imagePicker2 = [[UIImagePickerController alloc] init];
        imagePicker2.delegate = self;
        [self presentViewController:imagePicker2 animated:YES completion:NULL];
    }
}

//allows for image to be set as the background for the drawing view
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
   
    CGRect rect = CGRectMake(0.0, 0.0, 320.0, 374.0);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_drawView.paths removeAllObjects];
    _drawView.backgroundColor = [UIColor colorWithPatternImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    [_drawView setNeedsDisplay];
    
   
}

@end
