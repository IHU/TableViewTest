//
//  ViewController.h
//  TableViewTest
//
//  Created by Filiz Uslu on 22/02/13.
//  Copyright (c) 2013 Filiz Uslu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
    @property (strong, nonatomic) NSString *selectedIndexPath;
    @property (strong, nonatomic) NSString *humanText;
    @property ( strong,nonatomic) NSString *cellText;
@property (strong, nonatomic) NSDictionary *json;
@property (strong,nonatomic) NSArray *latestLoan;



@end
