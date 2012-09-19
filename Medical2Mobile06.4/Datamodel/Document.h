//
//  Document.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Document : NSManagedObject

@property (nonatomic, retain) NSDate * dateinsert;
@property (nonatomic, retain) NSString * documentname;
@property (nonatomic, retain) NSString * documentType;
@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) Patient *patient;

@end
