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
#import "KFOWMWindModel.h"
#import "KFOWMWeatherModel.h"


@interface WeatherForcaastDetailsViewController ()<KFOWMWeatherModel>

@property (nonatomic, strong) KFOpenWeatherMapAPIClient *apiClient;
@property (nonatomic, strong) KFOWMWeatherResponseModel *responseModel;
@property (weak, nonatomic) IBOutlet UILabel *cityNameLable;
@property (weak, nonatomic) IBOutlet UILabel *rainyChancesLable;
@property (weak, nonatomic) IBOutlet UILabel *tempratureLable;
@property (weak, nonatomic) IBOutlet UILabel *humidityLable;
@property (weak, nonatomic) IBOutlet UILabel *windLable;
@property (weak, nonatomic) IBOutlet UILabel *pressureLable;

@end

@implementation WeatherForcaastDetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"Wheather Details";
    [self.navigationItem.leftBarButtonItem setTitle:@"Back"];
    
    self.apiClient = [[KFOpenWeatherMapAPIClient alloc] initWithAPIKey:@"c6e381d8c7ff98f0fee43775817cf6ad" andAPIVersion:@"2.5"];
    self.apiClient.temperatureType = KFOWMTemperatureTypeFahrenheit;
    self.apiClient.unitType = KFOWMUnitTypeMetric;
    
    
    [self.apiClient weatherForCoordinate:_locationCoordinate withResultBlock:^(BOOL success, id responseData, NSError *error)
     {
         if (success)
         {
             _responseModel = (KFOWMWeatherResponseModel *)responseData;
             NSLog(@"received weather: %@, temperature: %@ C, %@%%rH, %@ mbar", _responseModel.cityName, _responseModel.mainWeather.temperature, _responseModel.mainWeather.humidity, _responseModel.mainWeather.pressure)
             ;
             [self updateWheatherForcast];
         }
         else
         {
             NSLog(@"could not get weather: %@", error);
         }
     }];
}

- (void)updateWheatherForcast {

    self.cityNameLable.text = _bookmarkedLocation.address;
    
  KFOWMWeatherModel *wheather = (KFOWMWeatherModel *)[_responseModel.weather firstObject];
    
    self.rainyChancesLable.text = [NSString stringWithFormat:@"%@: %@",wheather.main, wheather.weatherDescription];
    self.tempratureLable.text = [NSString stringWithFormat:@"Temperature: %0.1f˚C", [[self.apiClient kelvinToCelcius:_responseModel.mainWeather.temperature] doubleValue]];
    self.humidityLable.text = [NSString stringWithFormat:@"Humidity: %0.2f%%rH", [_responseModel.mainWeather.humidity doubleValue]];
    self.windLable.text = [NSString stringWithFormat:@"Wind Speed: %@ m/s, Direction: %0.2f˚", _responseModel.wind.speed, [_responseModel.wind.deg doubleValue]];
    self.pressureLable.text = [NSString stringWithFormat:@"Pressure: %0.2fhpa", [_responseModel.mainWeather.pressure doubleValue]];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
