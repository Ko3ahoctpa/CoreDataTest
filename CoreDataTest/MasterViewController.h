//
//  MasterViewController.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface MasterViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managerContext;
@property (strong, nonatomic) NSArray *usersArray;


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end