//
//  ViewController.m
//  InOurPrime
//
//  Created by Donny Davis on 4/27/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITextField *numbersTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkAnswerButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *calculationPicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)checkAnswer:(UIButton *)sender {
}

@end
