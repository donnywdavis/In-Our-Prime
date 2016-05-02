//
//  PrimeBrain.m
//  InOurPrime
//
//  Created by Donny Davis on 4/27/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import "PrimeBrain.h"

@implementation PrimeBrain

- (BOOL)isPrimeNumber:(NSUInteger)number {
    int counter = 2;
    int range = sqrt((int)number);
    
    while (counter <= range) {
        if ((number % counter == 0) && (number / counter > 1)) {
            return NO;
        }
        counter += 1;
    }
    
    return YES;
}

- (NSArray *)getPrimeFactorsForNumber:(NSUInteger)number {
    int counter = 2;
    int range = sqrt((int)number);
    NSMutableArray *primeFactors = nil;
    
    while (counter <= range) {
        if ((number % counter == 0) && [self isPrimeNumber:counter]) {
            if (!primeFactors) {
                primeFactors = [[NSMutableArray alloc] init];
            }
            [primeFactors addObject:[NSString stringWithFormat:@"%d", counter]];
        }
        counter += 1;
    }
    return primeFactors;
}

- (NSInteger)getLargestPrimeFactorBetweenNumber:(NSUInteger)firstNumber andAnotherNumber:(NSUInteger)secondNumber {
    NSArray *firstNumberArray = [[NSArray alloc] initWithArray:[self getPrimeFactorsForNumber:firstNumber]];
    NSArray *secondNumberArray = [[NSArray alloc] initWithArray:[self getPrimeFactorsForNumber:secondNumber]];
    NSInteger largestCommonFactor = 0;
    
    if (firstNumberArray && secondNumberArray) {
        for (NSString *first in firstNumberArray) {
            for (NSString *second in secondNumberArray) {
                if (([first integerValue] == [second integerValue]) && ([first integerValue] > largestCommonFactor)) {
                    largestCommonFactor = [first integerValue];
                }
            }
        }
    }
    
    return largestCommonFactor;
}

@end
