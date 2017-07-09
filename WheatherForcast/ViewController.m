//
//  ViewController.m
//  WheatherForcast
//
//  Created by Pravin Raosaheb Fand on 08/07/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import "ViewController.h"
#import "KFOpenWeatherMapAPIClient.h"
#import "KFOWMWeatherResponseModel.h"
#import "KFOWMMainWeatherModel.h"
#import "KFOWMWeatherModel.h"
#import "KFOWMForecastResponseModel.h"
#import "KFOWMCityModel.h"
#import "KFOWMDailyForecastResponseModel.h"
#import "KFOWMDailyForecastListModel.h"
#import "KFOWMSearchResponseModel.h"
#import "KFOWMSystemModel.h"
#import "LMGeocoder.h"
#import "CustomLocationPickerVC.h"

@interface ViewController ()

@property (nonatomic, strong) KFOpenWeatherMapAPIClient *apiClient;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.apiClient = [[KFOpenWeatherMapAPIClient alloc] initWithAPIKey:@"c6e381d8c7ff98f0fee43775817cf6ad" andAPIVersion:@"2.5"];
    
    [self.apiClient weatherForCityName:@"Pune" withResultBlock:^(BOOL success, id responseData, NSError *error)
     {
         if (success)
         {
             KFOWMWeatherResponseModel *responseModel = (KFOWMWeatherResponseModel *)responseData;
             NSLog(@"received weather: %@, temperature: %@ K, %@%%rH, %@ mbar", responseModel.cityName, responseModel.mainWeather.temperature, responseModel.mainWeather.humidity, responseModel.mainWeather.pressure);
         }
         else
         {
             NSLog(@"could not get weather: %@", error);
         }
     }];
    
    [[LMGeocoder sharedInstance] geocodeAddressString:@"Pune"
                                              service:kLMGeocoderGoogleService
                                    completionHandler:^(NSArray *results, NSError *error) {
                                        if (results.count && !error) {
                                            LMAddress *address = [results firstObject];
                                            NSLog(@"Coordinate: (%f, %f)", address.coordinate.latitude, address.coordinate.longitude);
                                        }
                                    }];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(18.520430, 73.856744);
    
    [[LMGeocoder sharedInstance] reverseGeocodeCoordinate:coordinate
                                                  service:kLMGeocoderGoogleService
                                        completionHandler:^(NSArray *results, NSError *error) {
                                            if (results.count && !error) {
                                                LMAddress *address = [results firstObject];
                                                NSLog(@"Address: %@", address.formattedAddress);
                                            }
                                        }];
    

    CustomLocationPickerVC *vc = [[CustomLocationPickerVC alloc] init];
    vc.lat = [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] : @"";
    vc.lng = [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] : @"";
    vc.address = CURRENT_ADDRESS ? CURRENT_ADDRESS : @"";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
