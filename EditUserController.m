//
//  EditUserController.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "EditUserController.h"
//#import "AppDelegate.h"

@interface EditUserController ()

@end


@implementation EditUserController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.managerContext = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    if (!self.detail) {
        self.navigationItem.title = @"Add user";
    } else {
        self.navigationItem.title = [NSString stringWithFormat:@"Edit: %@", self.detail.name];
        self.textFiedUserName.text = self.detail.name;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.timeZone = [NSTimeZone localTimeZone];
        
        [df setDateFormat:@"dd.MM.YYYY"];
        
        self.textFieldUserBirthDay.text = [df stringFromDate:self.detail.birthday];
        }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonSaveUser:)];
    
    // вызов dataPicker при нажатии на textFieldUserBirthDay
    self.dataPicker = [[UIDatePicker alloc] init];
    [self.dataPicker addTarget:self action:@selector(changeValueInDatePicker:) forControlEvents:UIControlEventValueChanged];
    [self.textFieldUserBirthDay setInputView:self.dataPicker];

}


- (void)changeValueInDatePicker:(id)sender {
    self.textFieldUserBirthDay.text = self.dataPicker.date.description;
}


- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonSaveUser:(UIButton *)sender {
    
    if (!self.detail) {
        
        NSLog(@"Edit USER");
        
        //User *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managerContext];
        //User *userObj = [[User alloc] init];
        
        //userObj.name = self.textFiedUserName.text;
        //userObj.birthday = self.dataPicker.date;
        //[self.managerContext save:nil];
        
//        [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext];
        NSMutableDictionary *userDic = [[NSMutableDictionary alloc] init];
        [userDic setObject:@"name" forKey:self.textFiedUserName.text];
        [userDic setObject:@"birthday" forKey:self.textFieldUserBirthDay.text];
        
        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
        
        [notification postNotificationName:@"editUser" object:nil userInfo:userDic];
        
    } else {
        
        self.detail.name = self.textFiedUserName.text;
        self.detail.birthday = self.dataPicker.date;
        
//        NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
//        
//        [notification postNotificationName:@"saveUser" object:nil];
//        
//        [self.navigationController popToRootViewControllerAnimated:YES];
        
        NSLog(@"Save USER");
    }
    
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification postNotificationName:@"saveUser" object:nil];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
