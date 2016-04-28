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
    
    while (counter <= (int)number) {
        if ((number % counter == 0) && (number / counter > 1)) {
            return NO;
        }
        counter += 1;
    }
    
    return YES;
}

- (NSArray *)getPrimeFactorsForNumber:(NSUInteger)number {
    return @[];
}

- (NSNumber *)getLargestPrimeFactorBetweenArray:(NSUInteger)firstNumber andAnotherArray:(NSUInteger)secondNumber {
    return @0;
}

@end
