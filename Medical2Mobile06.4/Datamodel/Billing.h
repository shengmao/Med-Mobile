//
//  Billing.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 28.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Billing : NSManagedObject

@property (nonatomic, retain) NSNumber * cost;
@property (nonatomic, retain) NSDate * dateinsert;
@property (nonatomic, retain) NSDate * datepayed;
@property (nonatomic, retain) NSNumber * iscalculated;
@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) Patient *patient;

@end
