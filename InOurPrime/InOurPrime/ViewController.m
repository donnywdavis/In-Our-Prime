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

@property (strong, nonatomic) PrimeBrain *brain;

- (NSString *)formatStringFromArray:(NSArray *)numbersArray;
- (void)checkPrimeAction:(NSString *)numbersString;
- (void)primeFactorsAction:(NSString *)numbersString;
- (void)largestCommonPrimeAction:(NSString *)numbersString;
- (void)displayErrorForTitle:(NSString *)title message:(NSString *)message;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the delegate and the data source for the picker
    self.calculationPicker.delegate = self;
    self.calculationPicker.dataSource = self;
    
    self.brain = [[PrimeBrain alloc] init];
    
    // Set our available calculation options for the picker
    self.calculationOptionsArray = @[@"", @"Check if prime number", @"All prime factors", @"Largest common prime factor"];
    
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

- (void)displayErrorForTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBUtton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okBUtton];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Button Actions

- (IBAction)checkAnswer:(UIButton *)sender {
    switch ([self.calculationPicker selectedRowInComponent:0]) {
        case 1:
            [self checkPrimeAction:self.numbersTextField.text];
            break;
            
        case 2:
            [self primeFactorsAction:self.numbersTextField.text];
            break;
            
        case 3:
            if ([self.numbersTextField.text componentsSeparatedByString:@" "].count >= 2) {
                [self largestCommonPrimeAction:self.numbersTextField.text];
            } else {
                [self displayErrorForTitle:@"Error" message:@"You must enter two numbers separated by a space"];
            }
            break;
            
        default:
            break;
    }
    [self.numbersTextField resignFirstResponder];
}

#pragma mark - Calculation Methods

// Check if the number entered is a prime number or not and output the answer
- (void)checkPrimeAction:(NSString *)numbersString {
    if ([self.brain isPrimeNumber:[numbersString integerValue]]) {
        self.answerLabel.text = [NSString stringWithFormat:@"%@ is a prime number.", numbersString];
    } else {
        self.answerLabel.text = [NSString stringWithFormat:@"%@ is not a prime number.", numbersString];
    }
}

// Get all of the prime factors for a given number and output the results
- (void)primeFactorsAction:(NSString *)numbersString {
    NSArray *primeFactors = [[NSArray alloc] init];
    primeFactors = [self.brain getPrimeFactorsForNumber:[numbersString integerValue]];
    if (primeFactors) {
        self.answerLabel.text = [self formatStringFromArray:primeFactors];
    } else {
        self.answerLabel.text = [NSString stringWithFormat:@"There are no prime factors for %@.", numbersString];
    }
}

// Get the largest common prime factor between two numbers
- (void)largestCommonPrimeAction:(NSString *)numbersString {
    NSArray *numbers = [[NSArray alloc] initWithArray:[numbersString componentsSeparatedByString:@" "]];
    NSUInteger firstNumber = [numbers[0] integerValue];
    NSUInteger secondNumber = [numbers[1] integerValue];
    NSInteger largestCommonPrimeFactor = [self.brain getLargestPrimeFactorBetweenNumber:firstNumber andAnotherNumber:secondNumber];
    
    if (largestCommonPrimeFactor > 0) {
        self.answerLabel.text = [NSString stringWithFormat:@"The largest common prime factor between %lu and %lu is %ld.", (unsigned long)firstNumber, (unsigned long)secondNumber, (long)largestCommonPrimeFactor];
    } else {
        self.answerLabel.text = [NSString stringWithFormat:@"There are no common prime factors between %lu and %lu.", (unsigned long)firstNumber, (unsigned long)secondNumber];
    }
}

// Format a given array to output as a sentence with formatting for the possible answers
- (NSString *)formatStringFromArray:(NSArray *)numbersArray {
    NSString *answerString = @"";
    
    if (numbersArray.count > 1) {
        answerString = [NSString stringWithFormat:@"The prime factors for %@ are ", self.numbersTextField.text];
    } else {
        answerString = [NSString stringWithFormat:@"The prime factor for %@ is ", self.numbersTextField.text];
    }
    
    for (NSString *primeFactor in numbersArray) {
        if (numbersArray.count == 1) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@", primeFactor]];
        } else if ((numbersArray.count == 2) && (primeFactor == [numbersArray firstObject])) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@ ", primeFactor]];
        } else if (primeFactor == [numbersArray lastObject]) {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"and %@", primeFactor]];
        } else {
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@, ", primeFactor]];
        }
    }
    
    answerString = [answerString stringByAppendingString:@"."];
    
    return answerString;
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
            self.instructionsLabel.text = @"Enter two numbers separated by a space to see the largest common prime factor between them.";
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
    self.answerLabel.text = @"";
}

@end
