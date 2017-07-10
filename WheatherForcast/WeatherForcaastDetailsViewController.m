//
//  WeatherForcaastDetailsViewController.m
//  WheatherForcast
//
//  Created by Fand, Pravin : Group Centre on 7/10/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import "WeatherForcaastDetailsViewController.h"
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


@interface WeatherForcaastDetailsViewController ()
    
@property (nonatomic, strong) KFOpenWeatherMapAPIClient *apiClient;
@property (nonatomic, strong) KFOWMWeatherResponseModel *responseModel;

@end

@implementation WeatherForcaastDetailsViewController
    
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.apiClient = [[KFOpenWeatherMapAPIClient alloc] initWithAPIKey:@"c6e381d8c7ff98f0fee43775817cf6ad" andAPIVersion:@"2.5"];
    
    [self.apiClient weatherForCityName:@"Pune" withResultBlock:^(BOOL success, id responseData, NSError *error)
     {
         if (success)
         {
            _responseModel = (KFOWMWeatherResponseModel *)responseData;
             NSLog(@"received weather: %@, temperature: %@ K, %@%%rH, %@ mbar", _responseModel.cityName, _responseModel.mainWeather.temperature, _responseModel.mainWeather.humidity, _responseModel.mainWeather.pressure);
         }
         else
         {
             NSLog(@"could not get weather: %@", error);
         }
     }];
}
    
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    @end
