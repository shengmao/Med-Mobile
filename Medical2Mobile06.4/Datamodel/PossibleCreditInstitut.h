//
//  PossibleCreditInstitut.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface PossibleCreditInstitut : NSManagedObject

@property (nonatomic, retain) NSString * blz;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *patient;
@end

@interface PossibleCreditInstitut (CoreDataGeneratedAccessors)

- (void)addPatientObject:(Patient *)value;
- (void)removePatientObject:(Patient *)value;
- (void)addPatient:(NSSet *)values;
- (void)removePatient:(NSSet *)values;

@end
