//
//  ViewController.m
//  ScooterDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/5/31.
//  Copyright © 2019 Urbane. All rights reserved.
//

#import "ViewController.h"
#import <UEIoTBLEKit/UEIoTBLEKit.h>
#import "MBProgressHUD+SGQRCode.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *scooters;
@property (weak, nonatomic) IOTBLEManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [IOTBLEManager  sharedIOTBLEManager];
}

#pragma mark - actions

- (IBAction)scanButtonTapped:(id)sender {
    [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"start scanning peripherals..." toView:self.view];
    
    [self.manager startScanningDidDiscoverScootersBlock:^(NSArray<NSDictionary *> * _Nullable scooters) {
        self.scooters = scooters;
        [self.tableView reloadData];
    }];
}


#pragma mark - table view data source and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.scooters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSDictionary *scooter = self.scooters[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"NAME:%@, MAC:%@", scooter[IOTCommandScooterNameKey], scooter[IOTCommandScooterMACAddressKey]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@, Battery: %@, LockState:%@", scooter[IOTCommandScooterRSSIKey], scooter[IOTCommandScooterBatteryPercentKey], scooter[IOTCommandLockStateKey]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.manager cancelScan];
    NSDictionary *scooter = self.scooters[indexPath.row];
    
    [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"start connecting peripheral" toView:[UIApplication sharedApplication].keyWindow];

    [self.manager connectScooterWithMACAddress:scooter[IOTCommandScooterMACAddressKey] completion:^(BOOL isSuccess) {
        if (isSuccess) {
            [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"peripheral connect success" toView:[UIApplication sharedApplication].keyWindow];
            [self performSegueWithIdentifier:@"CommandSegue" sender:nil];
        } else {
            [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"peripheral connect failed" toView:[UIApplication sharedApplication].keyWindow];
        }
    }];
}

@end
