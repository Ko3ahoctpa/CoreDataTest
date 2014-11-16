//
//  User.h
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/14/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSDate *birthday;
@property (nonatomic, retain) NSNumber *age;

@end
