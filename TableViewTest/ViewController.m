//
//  ViewController.m
//  TableViewTest
//
//  Created by Filiz Uslu on 22/02/13.
//  Copyright (c) 2013 Filiz Uslu. All rights reserved.
//

#import "ViewController.h"
#define WcfSeviceURL [NSURL URLWithString: @"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]

@interface ViewController ()
  
@end

@implementation ViewController

@synthesize  selectedIndexPath;
@synthesize humanText;
@synthesize cellText;
@synthesize latestLoan;
@synthesize json;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfURL:WcfSeviceURL options:NSDataReadingUncached error:&error];
    selectedIndexPath = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if(!error)
    {
         json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:NSJSONReadingMutableContainers
                              error:&error];
        latestLoan = [json objectForKey:@"loans"];
        
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView * ) tableView
{
    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MainCell"];
                
                
    }
            
        // 1) Get the latest loan
        NSDictionary* loan = [latestLoan objectAtIndex:indexPath.row];
        
        // 2) Get the funded amount and loan amount
        NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
        NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
        float outstandingAmount = [loanAmount floatValue] -
        [fundedAmount floatValue];
        
        // 3) Set the label appropriately
        
        cellText = [NSString stringWithFormat:@"%@ %.0f", [loan objectForKey:@"name"], outstandingAmount];
        
    
    cell.textLabel.text = cellText;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) return @"Section 1";else return @"Section 2";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = [NSString stringWithFormat:@"Cell %d was selected",[indexPath row]];
    humanText = [NSString stringWithFormat:@"test %d",[indexPath row]];
    
   
        
        // 1) Get the latest loan
        NSDictionary* loan = [latestLoan objectAtIndex:indexPath.row];
        
        // 2) Get the funded amount and loan amount
        NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
        NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
        float outstandingAmount = [loanAmount floatValue] -
        [fundedAmount floatValue];
        
        // 3) Set the label appropriately
        humanText = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                             [loan objectForKey:@"name"],
                             [(NSDictionary*)[loan objectForKey:@"location"] 
                              objectForKey:@"country"],
                             outstandingAmount];
        
        
    
    
    UIAlertView *selectedCellAlert = [[UIAlertView alloc] initWithTitle:@"Cell Selected" message:humanText delegate:nil cancelButtonTitle:@"OKay" otherButtonTitles: nil];
    
    [selectedCellAlert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
