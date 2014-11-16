//
//  ViewController.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/14/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "AppDelegate.h"


@interface ViewController ()

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.managerContext = [(AppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    self.dataPicker = [[UIDatePicker alloc] init];
    [self.dataPicker addTarget:self action:@selector(changeValueInDatePicker:) forControlEvents:UIControlEventValueChanged];
    [self.textFieldBD setInputView:self.dataPicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)changeValueInDatePicker:(id)sender {
    self.textFieldBD.text = self.dataPicker.date.description;
}


- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark - IBActions

- (IBAction)buttonAd:(UIButton *)sender {
    
    User *userObj = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                                  inManagedObjectContext:self.managerContext];
    userObj.name = self.textFieldName.text;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"YYYY MMM HH"];
    userObj.birthday = self.dataPicker.date;
    
    userObj.age = @(self.textFieldAge.text.intValue);
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate saveContext]; // внесены изм. в контекс и сохранены в базу
}


// релоад таблицы

- (IBAction)buttonGet:(UIButton *)sender {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init]; // объект запрос к базе
    
    NSString *user = @"User";
    NSEntityDescription *entity = [NSEntityDescription entityForName:user
                                              inManagedObjectContext:self.managerContext]; // таблица к User, к контексту managerContext
    
    [fetchRequest setEntity:entity]; // запрос к таблице entity (+ возможна сортировка)
    
    NSArray *arrayUsers = [self.managerContext executeFetchRequest:fetchRequest
                                                             error:nil]; // получить массив по указанным условиям в fetchRequest
    
    User *lastUser = [arrayUsers lastObject];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    
    [df setDateFormat:@"YYYY MMMM HH"];
    
    self.labelName.text = lastUser.name;
    self.labelBirthDay.text = [df stringFromDate:lastUser.birthday]; // или черед NSDateFormatter
    self.labelAge.text = lastUser.age.stringValue;
}





@end
