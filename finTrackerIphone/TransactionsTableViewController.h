//
//  TransactionsTableViewController.h
//  finTrackerIphone
//
//  Created by Wei Zhang on 5/3/15.
//  Copyright (c) 2015 Wei Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionsTableViewController : UITableViewController

@property NSMutableArray *transactions;

@property NSMutableArray *dayIndex;

@property (nonatomic, weak) IBOutlet UINavigationBar* titleBar;
@end
