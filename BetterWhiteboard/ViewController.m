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

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tags = [[NSArray alloc] initWithObjects:@"Blue", @"Red", @"Yellow", @"Green", @"Purple", @"Black", @"Orange", @"Gray", nil];
    self.picker.showsSelectionIndicator =YES;
    CGAffineTransform rotate = CGAffineTransformMakeRotation(-3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [self.picker setTransform:rotate];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.tags objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    CGRect rect = CGRectMake(0, 0, 120, 80);
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    CGAffineTransform rotate = CGAffineTransformMakeRotation(3.14/2);
    rotate = CGAffineTransformScale(rotate, 0.25, 2.0);
    [label setTransform:rotate];
    label.text = [self.tags objectAtIndex:row];
    label.font = [UIFont systemFontOfSize:22.0];
    label.textAlignment = UITextAlignmentCenter;
    label.numberOfLines = 2;
    label.clipsToBounds = YES;
    return label ;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.tags.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch(row)
    {
        case(0):
            [_drawView setPathColor:[UIColor blueColor]];
            break;
        case(1):
            [_drawView setPathColor:[UIColor redColor]];
            break;
        case(2):
            [_drawView setPathColor:[UIColor yellowColor]];
            break;
        case(3):
            [_drawView setPathColor:[UIColor greenColor]];
            break;
        case(4):
            [_drawView setPathColor:[UIColor purpleColor]];
            break;
        case(5):
            [_drawView setPathColor:[UIColor blackColor]];
            break;
        case(6):
            [_drawView setPathColor:[UIColor orangeColor]];
            break;
        case(7):
            [_drawView setPathColor:[UIColor grayColor]];
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

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25.0;
}

- (IBAction)undo:(id)sender {
    //removes last path from _paths
    [_drawView.paths removeLastObject];
    //refreshes the view
    [_drawView setNeedsDisplay];
}

- (IBAction)changePathColor:(UIButton *)sender
{
    [_drawView setPathColor:[UIColor whiteColor]];
}

- (IBAction)changeSize:(UISlider *)sender
{
    _drawView.pathWidth = sender.value;
}

- (IBAction)cameraPressed:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload a picture" message:nil delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Take a photo", @"Choose existing", nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}

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

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = 320.0/374.0;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = 374.0 / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = 374.0;
        }
        else{
            imgRatio = 320.0 / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = 320.0;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, 320.0, 374.0);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _drawView.backgroundColor = [UIColor colorWithPatternImage:image];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
   
}

@end
