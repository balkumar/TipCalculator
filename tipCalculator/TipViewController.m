//
//  TipViewController.m
//  tipCalculator
//
//  Created by Bal Kumar on 9/8/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;

- (void) updatevalues;
- (void) onSettingsButton;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"Tip Calculator";// Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updatevalues]; // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat: [@"-1" floatValue]  forKey:@"defPct"];
    [defaults synchronize];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    
    [self updatevalues];
}

- (void)updatevalues{
    
    float billAmount = [self.billTextField.text floatValue];
   ////// NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    
    NSString  *str=[self.tipControl titleForSegmentAtIndex:0];
    NSLog(@"before setting %@", str);
    
    NSString * tiptmp =[ [self.tipControl titleForSegmentAtIndex: self.tipControl.selectedSegmentIndex ] stringByReplacingOccurrencesOfString:@"%" withString:@""];
    
    NSLog(@"-----%@",tiptmp);
    
    //float tipAmount = billAmount* [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float tipAmount = .01* billAmount* [tiptmp floatValue];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *stringValue = [defaults objectForKey:@"defPct"];
   
    float defPctval =[stringValue floatValue];
    //NSLog(@"before setting %.2f", defPctval);
    
    if (defPctval > 0 ) {
    tipAmount = billAmount * (defPctval/100);
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", defPctval ];
    
    NSLog(@"got pct  %@", stringValue);
        
    [self.tipControl setSelectedSegmentIndex:0];
    [self.tipControl setTitle:[[[NSNumber numberWithFloat:defPctval] stringValue]  stringByAppendingString:@"%"] forSegmentAtIndex:0];
          defaults = [NSUserDefaults standardUserDefaults];
          [defaults setFloat: [@"-1" floatValue]  forKey:@"defPct"];
          [defaults synchronize];
        
    }

    
    float totalAmount = billAmount + tipAmount ;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%.2f",totalAmount];

    
}


- (void) onSettingsButton{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
     [self updatevalues];
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}


@end
