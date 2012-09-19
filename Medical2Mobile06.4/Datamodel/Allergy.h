//
//  Allergy.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Allergy : NSManagedObject

@property (nonatomic, retain) NSString * shortdescription;
@property (nonatomic, retain) Patient *patient;

@end
