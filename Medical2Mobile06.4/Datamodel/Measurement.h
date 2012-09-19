//
//  Measurement.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient, PossibleToMeasure, User;

@interface Measurement : NSManagedObject

@property (nonatomic, retain) NSDate * dateinsert;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) PossibleToMeasure *possibleToMeasure;
@property (nonatomic, retain) User *user;

@end
