//
//  SettingsViewController.m
//  tipCalculator
//
//  Created by Bal Kumar on 9/8/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
- (IBAction)onTapInSettings:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *defPctTextField;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapInSettings:(id)sender {
       [self.view endEditing:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat: [self.defPctTextField.text floatValue]  forKey:@"defPct"];
    [defaults synchronize];
    
    NSLog(@"inside setting %.2f intap", [self.defPctTextField.text floatValue] );
    
    
}
@end
