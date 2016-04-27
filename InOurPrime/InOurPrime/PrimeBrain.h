//
//  PrimeBrain.h
//  InOurPrime
//
//  Created by Donny Davis on 4/27/16.
//  Copyright © 2016 Donny Davis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeBrain : NSObject

- (BOOL)isPrimeNumber:(NSUInteger)number;
- (NSArray *)getPrimeFactorsForNumber:(NSUInteger)number;
- (NSNumber *)getLargestPrimeFactorBetweenArray:(NSUInteger)firstNumber andAnotherArray:(NSUInteger)secondNumber;

@end
