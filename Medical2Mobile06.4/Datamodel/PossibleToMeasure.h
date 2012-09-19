//
//  PossibleToMeasure.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Measurement;

@interface PossibleToMeasure : NSManagedObject

@property (nonatomic, retain) NSString * abbreviation;
@property (nonatomic, retain) NSString * longdescription;
@property (nonatomic, retain) NSString * referenceFemale;
@property (nonatomic, retain) NSString * referenceMale;
@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) NSString * unitOfMeasure;
@property (nonatomic, retain) NSSet *measurement;
@end

@interface PossibleToMeasure (CoreDataGeneratedAccessors)

- (void)addMeasurementObject:(Measurement *)value;
- (void)removeMeasurementObject:(Measurement *)value;
- (void)addMeasurement:(NSSet *)values;
- (void)removeMeasurement:(NSSet *)values;

@end
