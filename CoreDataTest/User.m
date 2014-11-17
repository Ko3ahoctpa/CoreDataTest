//
//  User.m
//  CoreDataTest
//
//  Created by Dmitriy Demchenko on 11/14/14.
//  Copyright (c) 2014 Dmitriy Demchenko. All rights reserved.
//

#import "User.h"
#import "EditUserController.h"


@implementation User

@dynamic name;
@dynamic birthday;
@dynamic age;


//- (void)setBirthday:(NSDate *)birthday {
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    
//    NSDateComponents *resultComponents = [calendar components: NSCalendarUnitYear fromDate:birthday toDate:[NSDate date] options:0];
//    
//    self.age = [NSNumber numberWithInteger:resultComponents.year];
//}

#pragma mark - Events change properies

- (void)willChangeValueForKey:(NSString *)key{
    NSLog(@"willChangeValueForKey: %@", key);
}
- (void)didChangeValueForKey:(NSString *)key{
    NSLog(@"didChangeValueForKey: %@", key);
}

@end
