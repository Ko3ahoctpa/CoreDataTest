//
//  ViewController.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/14/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface ViewController : UIViewController


@property (strong, nonatomic) NSManagedObjectContext *managerContext;

@property (strong, nonatomic) UIDatePicker *dataPicker;

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelBirthDay;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;

@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldBD;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAge;

- (IBAction)buttonGet:(UIButton *)sender;
- (IBAction)buttonAd:(UIButton *)sender;



@end