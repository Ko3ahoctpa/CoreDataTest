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
    
    // вызов dataPicker при нажатии на textFieldUserBirthDay
    self.dataPicker = [[UIDatePicker alloc] init];
    self.dataPicker.datePickerMode = UIDatePickerModeDate; // изменяем стить dataPicker
    [self.dataPicker addTarget:self action:@selector(changeValueInDatePicker:) forControlEvents:UIControlEventValueChanged];
    
    // delegate для textFied-ов
    self.textFiedUserName.delegate = self;
    self.textFieldUserBirthDay.delegate = self;
    
    self.textFiedUserName.keyboardAppearance = UIKeyboardAppearanceDark; // стиль клавиатуры
    self.textFiedUserName.returnKeyType = UIReturnKeyNext; // стиль клавиши RETURN
    
    if (!self.detail.name) {
        self.navigationItem.title = @"Add user";
    } else {
        self.navigationItem.title = [NSString stringWithFormat:@"Edit %@", self.detail.name];
        
        self.dataPicker.date = self.detail.birthday;
    }
    
    self.textFiedUserName.text = self.detail.name;
    
    [self setAge:self.detail.age];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    self.textFieldUserBirthDay.text = [df stringFromDate:self.detail.birthday];
    
    // создаем кновку SAVE USER
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buttonSaveUser:)];
    
    
    [self.textFieldUserBirthDay setInputView:self.dataPicker];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)changeValueInDatePicker:(id)sender {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone localTimeZone];
    [df setDateFormat:@"dd.MM.YYYY"];
    
    self.textFieldUserBirthDay.text = [df stringFromDate:self.dataPicker.date];
    
    // вычисление возроста (текущая дата - ДР)
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *resultComponents = [calendar components: NSCalendarUnitYear fromDate:self.dataPicker.date toDate:[NSDate date] options:0];
    self.detail.age = [NSNumber numberWithInteger:resultComponents.year];
    
    [self setAge:self.detail.age];
}


// убирает клавиатуру и dataPicker при клике по view
- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate

// вызывается после нажатия клавиши NEXT (return)
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.textFiedUserName]) {
        [self.textFieldUserBirthDay becomeFirstResponder]; // после нажатия клавиши RETURN курсор переключается на сл. textField
    } /*else {
        [textField resignFirstResponder]; // убирает клавиатуру после нажатия клавиши RETURN
    }*/
    return YES;
}


- (void)buttonSaveUser:(UIButton *)sender {
    
    self.detail.name = self.textFiedUserName.text;
    
    self.detail.birthday = self.dataPicker.date;
   
    // генерируем событие
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveUser" object:nil];
    
    // вернуться на главный контроллер
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)setAge: (NSNumber*) age {
    
    self.labelAge.text = [NSString stringWithFormat:@"age: %@", age];
}




@end
