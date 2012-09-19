//
//  DetailedMenu.h
//  Medical2Mobile
//
//  Created by Sandra Möller on 26.07.12.
//  Copyright (c) 2012 Techedge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DetailedMenu : NSManagedObject

@property (nonatomic, retain) NSString * displayedname;
@property (nonatomic, retain) NSString * seguename;
@property (nonatomic, retain) NSData * picture;

@end
