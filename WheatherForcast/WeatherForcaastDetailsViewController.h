//
//  WeatherForcaastDetailsViewController.h
//  WheatherForcast
//
//  Created by Fand, Pravin : Group Centre on 7/10/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BookmarkedLocation.h"

@interface WeatherForcaastDetailsViewController : UIViewController

@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;
@property (nonatomic, strong) BookmarkedLocation *bookmarkedLocation;


@end
