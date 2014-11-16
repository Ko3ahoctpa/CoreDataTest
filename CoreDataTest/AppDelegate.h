//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/14/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // обмен данными, сохранение измененией, буфер между базой и приложением
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; // хранит модель базы (таблицы, поля)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; // связывает базу, несколько баз с приложением

- (void)saveContext; // для сохранения контекста
- (NSURL *)applicationDocumentsDirectory; // папка с БД


@end

