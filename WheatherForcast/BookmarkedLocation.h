//
//  BookmarkedLocation.h
//  WheatherForcast
//
//  Created by Pravin Raosaheb Fand on 10/07/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface BookmarkedLocation : NSManagedObject

@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;

@end
