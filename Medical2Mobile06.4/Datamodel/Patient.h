//
//  Patient.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Address, Allergy, Billing, Desease, Document, Measurement, PossibleCreditInstitut, PossibleInsurance, PossibleStationaryType;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * creditnumber;
@property (nonatomic, retain) NSDate * dateincome;
@property (nonatomic, retain) NSDate * dateleave;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSString * insurancenumber;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * mobilephone;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * room;
@property (nonatomic, retain) NSString * station;
@property (nonatomic, retain) NSSet *activity;
@property (nonatomic, retain) NSSet *adress;
@property (nonatomic, retain) NSSet *allergy;
@property (nonatomic, retain) NSSet *billing;
@property (nonatomic, retain) NSSet *desease;
@property (nonatomic, retain) NSSet *document;
@property (nonatomic, retain) PossibleInsurance *insurance;
@property (nonatomic, retain) NSSet *measurement;
@property (nonatomic, retain) PossibleCreditInstitut *possiblecreditinstitute;
@property (nonatomic, retain) PossibleStationaryType *possiblestationarytype;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addActivityObject:(Activity *)value;
- (void)removeActivityObject:(Activity *)value;
- (void)addActivity:(NSSet *)values;
- (void)removeActivity:(NSSet *)values;

- (void)addAdressObject:(Address *)value;
- (void)removeAdressObject:(Address *)value;
- (void)addAdress:(NSSet *)values;
- (void)removeAdress:(NSSet *)values;

- (void)addAllergyObject:(Allergy *)value;
- (void)removeAllergyObject:(Allergy *)value;
- (void)addAllergy:(NSSet *)values;
- (void)removeAllergy:(NSSet *)values;

- (void)addBillingObject:(Billing *)value;
- (void)removeBillingObject:(Billing *)value;
- (void)addBilling:(NSSet *)values;
- (void)removeBilling:(NSSet *)values;

- (void)addDeseaseObject:(Desease *)value;
- (void)removeDeseaseObject:(Desease *)value;
- (void)addDesease:(NSSet *)values;
- (void)removeDesease:(NSSet *)values;

- (void)addDocumentObject:(Document *)value;
- (void)removeDocumentObject:(Document *)value;
- (void)addDocument:(NSSet *)values;
- (void)removeDocument:(NSSet *)values;

- (void)addMeasurementObject:(Measurement *)value;
- (void)removeMeasurementObject:(Measurement *)value;
- (void)addMeasurement:(NSSet *)values;
- (void)removeMeasurement:(NSSet *)values;

@end
