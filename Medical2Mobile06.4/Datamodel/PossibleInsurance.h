//
//  PossibleInsurance.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface PossibleInsurance : NSManagedObject

@property (nonatomic, retain) NSString * field01_ik_kv_karte;
@property (nonatomic, retain) NSString * field02_name;
@property (nonatomic, retain) NSSet *patient;
@end

@interface PossibleInsurance (CoreDataGeneratedAccessors)

- (void)addPatientObject:(Patient *)value;
- (void)removePatientObject:(Patient *)value;
- (void)addPatient:(NSSet *)values;
- (void)removePatient:(NSSet *)values;

@end
