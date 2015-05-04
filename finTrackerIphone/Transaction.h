//
//  Transaction.h
//  finTrackerIphone
//
//  Created by Wei Zhang on 5/3/15.
//  Copyright (c) 2015 Wei Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject

@property NSString *vendor;
@property NSDate *day;
@property float amount;
@property NSString *categy;
@property NSString *typ;
@property NSString *acount;

@end
