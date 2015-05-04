//
//  TransactionTableViewCell.m
//  finTrackerIphone
//
//  Created by Wei Zhang on 5/3/15.
//  Copyright (c) 2015 Wei Zhang. All rights reserved.
//

#import "TransactionTableViewCell.h"

@implementation TransactionTableViewCell

@synthesize vendor = _vendor;
@synthesize categy = _categy;
@synthesize amount = _amount;
@synthesize sum = _sum;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
