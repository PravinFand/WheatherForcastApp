//
//  BookmarkedCityViewController.m
//  WheatherForcast
//
//  Created by Fand, Pravin : Group Centre on 7/10/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import "BookmarkedCityViewController.h"
#import "CustomLocationPickerVC.h"
#import "Config.h"
#import <CoreData/CoreData.h>
#import "BookmarkedLocation.h"
#import "AppDelegate.h"
#import "WeatherForcaastDetailsViewController.h"

@interface BookmarkedCityViewController ()

@property (nonatomic, strong) NSArray *bookmarkedLocations;
@property (nonatomic, strong) BookmarkedLocation *bookmarkedLocation;

@end

@implementation BookmarkedCityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [CommonFunctions setRightBarButtonItemWithTitle:nil
                                 andBackGroundImage:[UIImage imageNamed:@"search"]
                                        andSelector:@selector(addNewLocationClicked)
                                         withTarget:self
                                       onController:self];
    self.title = @"Bookmarked Locations";
    
    [self fetchBookMarkedList];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_bookmarkedLocations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookmarkedCell" forIndexPath:indexPath];
    
    BookmarkedLocation *location = [_bookmarkedLocations objectAtIndex:indexPath.row];
    cell.textLabel.text = location.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _bookmarkedLocation = (BookmarkedLocation *)[_bookmarkedLocations objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WeatherForcaastDetailsViewController *detailsVC = (WeatherForcaastDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"WeatherForcaastDetailsVC"];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_bookmarkedLocation.lat doubleValue], [_bookmarkedLocation.lng doubleValue]);
    
    detailsVC.locationCoordinate = coordinate;
    detailsVC.bookmarkedLocation = _bookmarkedLocation;
    
    [self.navigationController pushViewController:detailsVC animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue destinationViewController] isKindOfClass:[CustomLocationPickerVC class]]) {
        CustomLocationPickerVC *vc = (CustomLocationPickerVC *)[segue destinationViewController];
        vc.lat = [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LATITUDE] : @"";
        vc.lng = [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] ? [NSString stringWithFormat:@"%f", CURRENT_LONGITUDE] : @"";
        vc.address = CURRENT_ADDRESS ? CURRENT_ADDRESS : @"";
    }
}

- (void)addNewLocationClicked {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomLocationPickerVC *customLocationPickerVC = (CustomLocationPickerVC *)[storyboard instantiateViewControllerWithIdentifier:@"CustomLocationPickerVC"];
    
    [self.navigationController pushViewController:customLocationPickerVC animated:YES];
}

- (IBAction)unwindFromLocationPickerToCreateOrder:(UIStoryboardSegue *)segue {
    
    if ([[segue sourceViewController] isKindOfClass:[CustomLocationPickerVC class]]) {
        
        CustomLocationPickerVC *vc = (CustomLocationPickerVC *)[segue sourceViewController];
        
        BookmarkedLocation *object = [NSEntityDescription insertNewObjectForEntityForName:@"BookmarkedLocationsEntity"
                                                                   inManagedObjectContext:APP_DELEGATE.managedObjectContext];
        [object setValue:vc.lat forKey:@"lat"];
        [object setValue:vc.lng forKey:@"lng"];
        [object setValue:vc.address forKey:@"address"];
        [object setValue:vc.city forKey:@"city"];
        [object setValue:vc.country forKey:@"country"];
        
        NSError *error;
        if (![APPDELEGATE.managedObjectContext save:&error]) {
            NSLog(@"Failed to save - error: %@", [error localizedDescription]);
        }
        
        [self fetchBookMarkedList];
    }
}

- (void)fetchBookMarkedList {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookmarkedLocationsEntity" inManagedObjectContext:APP_DELEGATE.managedObjectContext];
    [request setEntity:entity];
    
    NSError *errorFetch = nil;
    _bookmarkedLocations = [APP_DELEGATE.managedObjectContext executeFetchRequest:request error:&errorFetch];
    
    for (BookmarkedLocation *object in _bookmarkedLocations) {
        NSLog(@"\nobject value1 = %@", object.city);
        NSLog(@"\nobject value1 = %@", object.lat);
        NSLog(@"\nobject value1 = %@", object.lng);
    }
    
    [self.tableView reloadData];
}

@end
