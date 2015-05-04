//
//  TransactionTableViewCell.h
//  finTrackerIphone
//
//  Created by Wei Zhang on 5/3/15.
//  Copyright (c) 2015 Wei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* vendor;
@property (nonatomic, weak) IBOutlet UILabel* categy;
@property (nonatomic, weak) IBOutlet UILabel* amount;
@property (nonatomic, weak) IBOutlet UILabel* sum;

@end
