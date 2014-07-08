//
//  ViewController.h
//  BetterWhiteboard
//
//  Created by Brendan Barnes on 7/3/14.
//  Copyright (c) 2014 Brendan Barnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"


@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet DrawingView *drawView;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (strong, nonatomic) NSArray *colors;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *selectedColor;


- (IBAction)changePathColor:(id)sender;
- (IBAction)changeSize:(id)sender;
- (IBAction)undo:(id)sender;
- (IBAction)save:(id)sender;

@end
