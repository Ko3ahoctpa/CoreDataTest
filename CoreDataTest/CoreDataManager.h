//
//  CoreDataManager.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/17/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoreDataManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // обмен данными, сохранение измененией, буфер между базой и приложением
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel; // хранит модель базы (таблицы, поля)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator; // связывает базу, несколько баз с приложением


+ (CoreDataManager *)sharedManager;
- (void)saveContext; // для сохранения контекста
- (NSURL *)applicationDocumentsDirectory; // папка с БД


@end