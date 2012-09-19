//
//  PossibleClinicalIssue.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity;

@interface PossibleClinicalIssue : NSManagedObject

@property (nonatomic, retain) NSString * longdescription;
@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSSet *activity;
@end

@interface PossibleClinicalIssue (CoreDataGeneratedAccessors)

- (void)addActivityObject:(Activity *)value;
- (void)removeActivityObject:(Activity *)value;
- (void)addActivity:(NSSet *)values;
- (void)removeActivity:(NSSet *)values;

@end
