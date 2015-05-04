//
//  TransactionsTableViewController.m
//  finTrackerIphone
//
//  Created by Wei Zhang on 5/3/15.
//  Copyright (c) 2015 Wei Zhang. All rights reserved.
//

#import "Transaction.h"
#import "TransactionsTableViewController.h"
#import "TransactionTableViewCell.h"

@interface TransactionsTableViewController ()

@end

@implementation TransactionsTableViewController
@synthesize titleBar = _titleBar;

- (void)loadInitialData {

    self.transactions = [ [NSMutableArray alloc] init];

    NSDateFormatter *datformat = [[NSDateFormatter alloc] init];
    datformat.locale =[NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    datformat.dateFormat = @"MM/dd/yyyy";
    
    Transaction *t1 = [[Transaction alloc] init];
    t1.vendor = @"CVS";
    t1.amount = -7.70;
    t1.day = [datformat dateFromString:@"05/01/2015"];
    t1.typ = @"Groceries";
    t1.categy = @"Daily life";
    [self.transactions addObject:t1];
    
    Transaction *t2 = [[Transaction alloc] init];
    t2.vendor = @"Papasito Q";
    t2.amount = -18.72;
    t2.day = [datformat dateFromString:@"05/01/2015"];
    t2.typ = @"Eating out";
    t2.categy = @"Reimbursement";
    [self.transactions addObject:t2];
    
    Transaction *t3 = [[Transaction alloc] init];
    t3.vendor = @"Pronto";
    t3.amount = -30.04;
    t3.day = [datformat dateFromString:@"04/30/2015"];
    t3.typ = @"Eating out";
    t3.categy = @"Daily life";
    [self.transactions addObject:t3];
    
    
    Transaction *t4 = [[Transaction alloc] init];
    t4.vendor = @"BGP Quickbook";
    t4.amount = 3319.88;
    t4.day = [datformat dateFromString:@"04/30/2015"];
    t4.typ = @"Salary";
    t4.categy = @"Daily life";
    [self.transactions addObject:t4];
    
}

- (void)indexDataByDay {
    self.dayIndex = [ [NSMutableArray alloc] init];
    unsigned long numTransaction = [self.transactions count];
    
    NSDate *currentDay = NULL;
    for(unsigned long i=0; i < numTransaction; ++i) {
        Transaction *t= [self.transactions objectAtIndex:i];
        
        if (currentDay == NULL || ![currentDay isEqualToDate: t.day]) {
            [self.dayIndex addObject: [NSNumber numberWithInteger:i]];
            currentDay = t.day;
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self loadInitialData];
    
    [self indexDataByDay];
    
    [self.titleBar setTitleVerticalPositionAdjustment:10.0 forBarMetrics:UIBarMetricsDefault];
    //[self.titleBar set]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.dayIndex count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section==[self.dayIndex count]-1) {
        unsigned long numTransaction = [self.transactions count];
        unsigned long lastSectionBgn = [[self.dayIndex objectAtIndex:section] integerValue];
        return numTransaction - lastSectionBgn;
    }
    
    NSInteger sectionBgn = [[self.dayIndex objectAtIndex:section] integerValue];
    NSInteger sectionEnd = [[self.dayIndex objectAtIndex:section+1] integerValue];
    return sectionEnd - sectionBgn;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionProtoCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger sectionIdx = indexPath.section;
    NSInteger transactionIdx = [[self.dayIndex objectAtIndex: sectionIdx] integerValue] + indexPath.row;
    Transaction *transaction = [self.transactions objectAtIndex:transactionIdx];
    cell.vendor.text = transaction.vendor;
    if (transaction.amount < 0) {
        cell.amount.text = [NSString stringWithFormat:@"$%.2f", -transaction.amount];
        cell.amount.textColor = [UIColor colorWithRed:0.9 green:0.0 blue:0.0 alpha:1.0];
    }
    else {
        cell.amount.text = [NSString stringWithFormat:@"$%.2f", transaction.amount];
        cell.amount.textColor = [UIColor colorWithRed:0.0 green:0.6 blue:0.0 alpha:1.0];
    }
    
    cell.categy.text = transaction.categy;
    cell.sum.text = [NSString stringWithFormat:@"%.2f", 0.0];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSAssert( section < [self.dayIndex count], @"section index out of range" );
    NSInteger transid = [[self.dayIndex objectAtIndex:section] integerValue];
    Transaction *transaction = [self.transactions objectAtIndex:transid];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];

    UILabel *label = [[UILabel alloc] init];
    label.text = [formatter stringFromDate:transaction.day];
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor lightGrayColor];
    [label setFont: [UIFont systemFontOfSize:12] ];
    return label;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
