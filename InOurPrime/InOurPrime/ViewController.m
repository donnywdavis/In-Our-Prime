//
//  ViewController.m
//  InOurPrime
//
//  Created by Donny Davis on 4/27/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "ViewController.h"
#import "PrimeBrain.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITextField *numbersTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkAnswerButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *calculationPicker;

@property (strong, nonatomic) NSArray *calculationOptionsArray;
@property (strong, nonatomic) NSArray *calculationMethodsArray;

@property (strong, nonatomic) PrimeBrain *brain;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the delegate and the data source for the picker
    self.calculationPicker.delegate = self;
    self.calculationPicker.dataSource = self;
    
    self.brain = [[PrimeBrain alloc] init];
    
    // Set our available calculation options for the picker
    self.calculationOptionsArray = @[@"", @"Check Prime Number", @"Get all prime factors", @"Get largest common prime factor"];
    
    // Disable the check button until a calculation option is selected
    self.checkAnswerButton.enabled = NO;
    self.instructionsLabel.text = @"";
    self.answerLabel.text = @"";
    
    self.numbersTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)checkAnswer:(UIButton *)sender {
    switch ([self.calculationPicker selectedRowInComponent:0]) {
        case 1:
            if ([self.brain isPrimeNumber:(NSUInteger)[self.numbersTextField.text integerValue]]) {
                self.answerLabel.text = [NSString stringWithFormat:@"%@ is a prime number.", self.numbersTextField.text];
            } else {
                self.answerLabel.text = [NSString stringWithFormat:@"%@ is not a prime number.", self.numbersTextField.text];
            }
            break;
            
        default:
            break;
    }
    [self.numbersTextField resignFirstResponder];
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.calculationOptionsArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (row) {
        case 1:
            self.instructionsLabel.text = @"Enter a number to check if it is a prime number or not.";
            break;
            
        case 2:
            self.instructionsLabel.text = @"Enter a number to see all of the prime factors for that number";
            break;
            
        case 3:
            self.instructionsLabel.text = @"Enter two numbers separated by a comma to see the largest common prime number between them.";
            break;
            
        default:
            self.instructionsLabel.text = @"";
            self.checkAnswerButton.enabled = NO;
            break;
    }
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.calculationOptionsArray.count;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.numbersTextField.text = @"";
    self.checkAnswerButton.enabled = YES;
}

@end
