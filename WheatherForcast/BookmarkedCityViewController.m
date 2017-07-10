//
//  BookmarkedCityViewController.m
//  WheatherForcast
//
//  Created by Fand, Pravin : Group Centre on 7/10/17.
//  Copyright © 2017 Pravin Raosaheb Fand. All rights reserved.
//

#import "BookmarkedCityViewController.h"
#import "CustomLocationPickerVC.h"

@interface BookmarkedCityViewController ()

@end

@implementation BookmarkedCityViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
 
    [CommonFunctions setRightBarButtonItemWithTitle:nil
                                 andBackGroundImage:[UIImage imageNamed:@"search"]
                                        andSelector:@selector(addNewLocationClicked)
                                         withTarget:self
                                       onController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookmarkedCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"Pune";
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   // [self performSegueWithIdentifier:@"showWheatherForcast" sender:self];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void)addNewLocationClicked {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CustomLocationPickerVC *customLocationPickerVC = (CustomLocationPickerVC *)[storyboard instantiateViewControllerWithIdentifier:@"CustomLocationPickerVC"];
        
    [self.navigationController pushViewController:customLocationPickerVC animated:YES];
}

- (IBAction)unwindFromLocationPickerToCreateOrder:(UIStoryboardSegue *)segue {
   
    if ([[segue sourceViewController] isKindOfClass:[CustomLocationPickerVC class]]) {
        //        ProfileCell *cell = (ProfileCell*)[self.registerTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        CustomLocationPickerVC *vc = (CustomLocationPickerVC *)[segue sourceViewController];
        
        
        //self.labelLat.text = [NSString stringWithFormat:@"LAT - %@", vc.lat];
        //self.labelLng.text = [NSString stringWithFormat:@"LNG - %@", vc.lng];
        //self.labelFormattedAddress.text = [NSString stringWithFormat:@"ADDRESS - %@", vc.address];
        //self.labelAddressName.text = [NSString stringWithFormat:@"CITY - %@, COUNTRY - %@", vc.city, vc.country];
    }
}

@end
