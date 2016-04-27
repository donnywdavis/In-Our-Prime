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
    return (number % 1 == 0) && (number % 2 == 0);
}

- (NSArray *)getPrimeFactorsForNumber:(NSUInteger)number {
    return @[];
}

- (NSNumber *)getLargestPrimeFactorBetweenArray:(NSUInteger)firstNumber andAnotherArray:(NSUInteger)secondNumber {
    return @0;
}

@end
