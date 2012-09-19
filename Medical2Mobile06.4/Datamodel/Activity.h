//
//  Activity.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient, PossibleClinicalIssue, User;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSString * longdescription;
@property (nonatomic, retain) NSString * sectiondate;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) PossibleClinicalIssue *possibleclinicalissue;
@property (nonatomic, retain) User *user;

@end
