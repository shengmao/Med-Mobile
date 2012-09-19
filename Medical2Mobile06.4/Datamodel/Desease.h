//
//  Desease.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient, PossibleICDNumber, User;

@interface Desease : NSManagedObject

@property (nonatomic, retain) NSDate * dateinsert;
@property (nonatomic, retain) NSDate * datestart;
@property (nonatomic, retain) NSString * longdescription;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) PossibleICDNumber *possibleicdnumber;
@property (nonatomic, retain) User *user;

@end
