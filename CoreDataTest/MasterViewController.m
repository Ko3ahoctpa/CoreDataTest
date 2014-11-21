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


@implementation MasterViewController {
   NSString *defaultTitle;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    defaultTitle = @"Users";
    
    self.navigationItem.title = defaultTitle;
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonAddUser:)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(saveUser:)
                                                      name:@"saveUser" object:nil];
    self.searchBar.delegate = self;
    
    self.searchBar.returnKeyType = UIReturnKeySearch;
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Actions

// Редактирование пользователя
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
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
    
    [self.navigationController pushViewController:editView animated:YES];
}


- (void)saveUser:(NSNotification *)notification {
    
    [[CoreDataManager sharedManager] saveContext]; // метод сохранения изменений для EDIT и ADD
    
    [self reloadTable];
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


// получает данные из БД и перезагружает таблицу
- (void)reloadTable {
    [self loadData];
    [self.tableView reloadData];
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [[CoreDataManager sharedManager] managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        [context deleteObject:[self.usersArray objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if(![context save:&error]){
            NSLog(@"Can't delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        [self reloadTable];
    }
}


#pragma mark - Search Bar methods

// CancelButton
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    
    self.searchBar.text = nil;
    
    [searchBar resignFirstResponder];
    
    self.navigationItem.title = defaultTitle;
    [self.view endEditing:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //
    
    [self reloadTable];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchBar.showsCancelButton = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:YES]; //
    
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if([searchText length] <= 0 ) {
        [self reloadTable];
        return;
    }
    
    // поиск в CoreData и вывод в tableView
    self.managerContext = [[CoreDataManager sharedManager] managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains [cd] %@", searchText];
    [request setPredicate:predicate];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
                                              inManagedObjectContext:self.managerContext];
    [request setEntity:entity];
    self.usersArray = [self.managerContext executeFetchRequest:request error:nil];
    
    [self.tableView reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    self.navigationItem.title = @"Search";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
    self.searchBar.showsCancelButton = YES;
}

// отписваемся от notification
- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end