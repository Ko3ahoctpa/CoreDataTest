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
    
    // создаем кновку SAVE USER
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonSaveUser:)];
    
    // вызов dataPicker при нажатии на textFieldUserBirthDay
    self.dataPicker = [[UIDatePicker alloc] init];
    self.dataPicker.datePickerMode = UIDatePickerModeDate; // изменяем стить dataPicker
    [self.dataPicker addTarget:self action:@selector(changeValueInDatePicker:) forControlEvents:UIControlEventValueChanged];
    [self.textFieldUserBirthDay setInputView:self.dataPicker];

}


- (void)changeValueInDatePicker:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    
    self.textFieldUserBirthDay.text = [df stringFromDate:self.dataPicker.date];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// убирает клавиатуру и dataPicker при клике по view
- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}


- (void)buttonSaveUser:(UIButton *)sender {
    
    self.detail.name = self.textFiedUserName.text;
    
    self.detail.birthday = self.dataPicker.date;
    
    // вычисление возроста (текущая дата - ДР)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *resultComponents = [calendar components: NSCalendarUnitYear fromDate:self.dataPicker.date toDate:[NSDate date] options:0];
    self.detail.age = [NSNumber numberWithInteger:resultComponents.year];
    
    // генерируем событие
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveUser" object:nil];
    
    // вернуться на главный контроллер
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
