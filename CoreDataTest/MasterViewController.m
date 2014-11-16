//
//  MasterViewController.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "MasterViewController.h"
#import "EditUserController.h"
#import "AppDelegate.h"
#import "User.h"

@interface MasterViewController ()

@end


@implementation MasterViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Users";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonAddUser:)];
    
    self.managerContext = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSString *user = @"User";
    NSEntityDescription *entity = [NSEntityDescription entityForName:user
                                              inManagedObjectContext:self.managerContext];
    
    [request setEntity:entity];
    
    self.usersArray = [self.managerContext executeFetchRequest:request error:nil];
    
//    NSLog(@"%@", self.usersArray);
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonAddUser:(id)sender {
    NSLog(@"add");
    
    EditUserController *editView = [self.storyboard instantiateViewControllerWithIdentifier:@"editUserController"];
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(saveUser:) name:@"editUser" object:nil];
    
    [self.navigationController pushViewController:editView animated:YES];
    
     
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersArray.count;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(saveUser:) name:@"saveUser" object:nil];
    
    NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
    
    User *editUser = [self.usersArray objectAtIndex:selectedRowIndex.row];
    
    [segue.destinationViewController setDetail:editUser];
    
    [segue.destinationViewController setManagerContext:self.managerContext];
    
    NSLog(@"prepareForSegue Edit user %@", segue.destinationViewController);
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    User *user = [self.usersArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.name;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    
    [df setDateFormat:@"dd.MM.YYYY"];
    
    cell.detailTextLabel.text = [df stringFromDate:user.birthday];
    
    return cell;
}


- (void)saveUser: (NSNotification *)n {
    
    NSLog(@"Notification %@", n.userInfo);
    User *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managerContext];
    userObj.name = [n.userInfo objectForKey:@"name"];
    userObj.birthday = [n.userInfo objectForKey:@"birthday"];
    
//    NSKeyValueObservingOptionNew
    
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    df.timeZone = [NSTimeZone localTimeZone];
//    [df setDateFormat:@"YYYY MMM HH"];
//    
//    User *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User"
//                                                  inManagedObjectContext:self.managerContext];
//    userObj.name = self.textFieldName.text;
//    userObj.birthday = self.dataPicker.date;
//    userObj.age = @(self.textFieldAge.text.intValue);
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext];
    
    [self.tableView reloadData];
}
@end