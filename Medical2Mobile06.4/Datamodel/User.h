//
//  User.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Desease, Measurement;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * active;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * loginname;
@property (nonatomic, retain) NSString * loginpassword;
@property (nonatomic, retain) NSSet *activity;
@property (nonatomic, retain) NSSet *desease;
@property (nonatomic, retain) NSSet *measurement;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addActivityObject:(Activity *)value;
- (void)removeActivityObject:(Activity *)value;
- (void)addActivity:(NSSet *)values;
- (void)removeActivity:(NSSet *)values;

- (void)addDeseaseObject:(Desease *)value;
- (void)removeDeseaseObject:(Desease *)value;
- (void)addDesease:(NSSet *)values;
- (void)removeDesease:(NSSet *)values;

- (void)addMeasurementObject:(Measurement *)value;
- (void)removeMeasurementObject:(Measurement *)value;
- (void)addMeasurement:(NSSet *)values;
- (void)removeMeasurement:(NSSet *)values;

@end
