//
//  MasterViewController.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "MasterViewController.h"
#import "EditUserController.h"
#import "CoreDataManager.h"
#import "User.h"

@interface MasterViewController ()

@end


@implementation MasterViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Users";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonAddUser:)];
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

// Редактирование пользователя
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveUser:)
                                                 name:@"saveUser" object:nil];
    
    // получаем индекс выбранной
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    User *user = [self.usersArray objectAtIndex:indexPath.row];
    
    [segue.destinationViewController setDetail:user];
}


// Добавление нового пользоваателя
- (void)buttonAddUser:(id)sender {
    
    // создаем объкет из User
    User *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                  inManagedObjectContext:self.managerContext];
    
    EditUserController *editView = [self.storyboard instantiateViewControllerWithIdentifier:@"editUserController"];
    
    // передаем в EditUserController объект userObj
    [editView setDetail:userObj];
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    [notification addObserver:self selector:@selector(saveUser:) name:@"saveUser" object:nil];
    
    
    [self.navigationController pushViewController:editView animated:YES];
}


- (void)saveUser:(NSNotification *)notification {
    
    [[CoreDataManager sharedManager] saveContext]; // метод сохранения изменений для EDIT и ADD
    
    [self loadData]; // обновить таблицу
    [self.tableView reloadData];
}


#pragma mark - Table Rows generate

//Получить данные из БД и заполнить массив
- (void)loadData {
    
    self.managerContext = [[CoreDataManager sharedManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:self.managerContext];
    
    [request setEntity:entity];
    
    self.usersArray = [self.managerContext executeFetchRequest:request error:nil];
}


// получаем кол-во ячеек из usersArray
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.usersArray.count;
}


// cоздание ячеек из массива
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    User *userObj = [self.usersArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (age: %@)", userObj.name, userObj.age];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    cell.detailTextLabel.text = [df stringFromDate:userObj.birthday];
    
    return cell;
}


// отписваемся от notification
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end