//
//  EditUserController.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/16/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface EditUserController : UIViewController


@property (strong, nonatomic) UIDatePicker *dataPicker;
@property (strong, nonatomic) User *detail;

@property (weak, nonatomic) IBOutlet UITextField *textFiedUserName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserBirthDay;


@end
