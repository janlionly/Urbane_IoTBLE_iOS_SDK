# Urbane Scooter - UEIoTBLEKit

## The easy way to use UEIoTBLEKit in iOS

### 1. Usage Scene

UEIoTBLEKit use for urbane's scooters, using APIs could control scooter by BLE.

### 2. Quick Example
```obj
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *scooters;
@property (weak, nonatomic) IOTBLEManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.create a singleton obj, you should get iphone bluetooth permission
    self.manager = [IOTBLEManager  sharedIOTBLEManager];

    // 2.scan for scooters
    [self.manager startScanningDidDiscoverScootersBlock:^(NSArray<NSDictionary *> * _Nullable scooters) {
        self.scooters = scooters;
        // ... print scooters to check infos of scooters(include each scooter's MAC Address)
        // ... show scooters info to UI here
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 3.find all scooters, then cancel scan
    [self.manager cancelScan];
    NSDictionary *scooter = self.scooters[indexPath.row];
    
    // 4.connect a selected scooter from UI by MAC address
    [self.manager connectScooterWithMACAddress:scooter[IOTCommandScooterMACAddressKey] completion:^(BOOL isSuccess) {
        if (isSuccess) {
            // connect a selected scooter success
        } else {
            // connect a selected scooter failed
        }
    }];
}

- (void)lockButtonTapped {
    // 5.send one of commands(IOTCommand) to control the scooter or to get infos of scooter
    [self.manager sendCommand:IOTCommandOpenLock params:nil receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
          // print feedbackInfo to see detail info after sended the command
    }];
}

// e.g. your self-define method
- (void)detectScooterInfo {
    // 6.you can detect IoT's feedback infos, then the protocol methods will be called below
    self.manager.delegate = self;
}

#pragma mark - iot ble manager delegate

- (void)iotBLEManagerActiveReportScooterInfos:(NSDictionary *)scooterInfos {
     // ...print scooterInfos to check
}

- (void)iotBLEManagerActiveReportErrorInfos:(NSDictionary *)errorInfos {
    // ...print errorInfos to check
}
```

### 3. How to use UEIoTBLEKit Framework into your project
* the iphone system version equal to or large than iOS 9.0
* copy the UEIoTBLEKit.framework into your project
* disable bitcode: select your project->TARGETS->Building Settings(selected All)->search 'bitcode' and then select 'Enable Bitcode' to NO

### 4. Late Update
we will support CocoaPods to integrate it into your project.

### 5. Contact Us
you can contact the author janlionly by email(jan_ron@qq.com)  Copyright © 2019 Urbane.
