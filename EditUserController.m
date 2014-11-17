//
//  EditUserController.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "EditUserController.h"


@interface EditUserController ()

@end


@implementation EditUserController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"Save user";
    
    self.textFiedUserName.text = self.detail.name;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    self.textFieldUserBirthDay.text = [df stringFromDate:self.detail.birthday];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonSaveUser:)];
    
    // вызов dataPicker при нажатии на textFieldUserBirthDay
    self.dataPicker = [[UIDatePicker alloc] init];
    self.dataPicker.datePickerMode = UIDatePickerModeDate;
    [self.dataPicker addTarget:self action:@selector(changeValueInDatePicker:) forControlEvents:UIControlEventValueChanged];
    [self.textFieldUserBirthDay setInputView:self.dataPicker];

}


- (void)changeValueInDatePicker:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    
    self.textFieldUserBirthDay.text = [df stringFromDate:self.dataPicker.date];
}


- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonSaveUser:(UIButton *)sender {
    self.detail.name = self.textFiedUserName.text;
    self.detail.birthday = self.dataPicker.date;
    
//    Генерируем событие
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveUser" object:nil];
    
//    Вернуться на главный контроллер
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
