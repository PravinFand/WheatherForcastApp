//
//  AppDelegate.h
//  WheatherForcast
//
//  Created by Pravin Raosaheb Fand on 08/07/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AVKit/AVKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Config.h"
#import "CommonFunctions.h"

@import GoogleMaps;
@import GooglePlaces;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

    /**
     Used to get current loation of user
     */
- (void)getCurrentLocation;
    
    /**
     used to get address from Location
     
     @param location CLLocation
     */
- (void) getAddressFromLocation: (CLLocation*) location;


    
@end

