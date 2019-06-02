//
//  CommandListViewController.m
//  ScooterDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/5/31.
//  Copyright © 2019 Urbane. All rights reserved.
//

#import "CommandListViewController.h"
#import <UEIoTBLEKit/UEIoTBLEKit.h>

@interface CommandListViewController ()<IOTBLEManagerDelegate>

@property (weak, nonatomic) IOTBLEManager *manager;
@property (weak, nonatomic) IBOutlet UILabel *accelerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedlimitingLabel;
@property (weak, nonatomic) IBOutlet UILabel *workModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gsensorLabel;
@property (weak, nonatomic) IBOutlet UILabel *alarmPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *unableLockPercentLabel;
@property (weak, nonatomic) IBOutlet UISlider *alarmSlider;
@property (weak, nonatomic) IBOutlet UISlider *unablelockSlider;

@end

@implementation CommandListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager = [IOTBLEManager sharedIOTBLEManager];
    self.manager.delegate = self;
}

#pragma mark - actions

- (IBAction)accelerationStepperValueChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.accelerationLabel.text = [NSString stringWithFormat:@"%d", (int)stepper.value];
    
    [self.manager sendCommand:IOTCommandAccelerationLevel params:@[@(stepper.value)] receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
        UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
        feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
        NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
        [feedbackTextView scrollRangeToVisible:bottom];
    }];
}
- (IBAction)speedLimitingSliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.speedlimitingLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
    
    [self.manager sendCommand:IOTCommandSpeedLimiting params:@[@(slider.value)] receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
        UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
        feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
        NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
        [feedbackTextView scrollRangeToVisible:bottom];
    }];
}

- (IBAction)workModeStepperValueChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.workModeLabel.text = [NSString stringWithFormat:@"%d", (int)stepper.value];
    
    [self.manager sendCommand:IOTCommandSetWorkMode params:@[@(stepper.value)] receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
        UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
        feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
        NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
        [feedbackTextView scrollRangeToVisible:bottom];
    }];
}
- (IBAction)gSensorStepperValueChanged:(id)sender {
    UIStepper *stepper = (UIStepper *)sender;
    self.gsensorLabel.text = [NSString stringWithFormat:@"%d", (int)stepper.value];
    
    [self.manager sendCommand:IOTCommandSetGSensorLevel params:@[@(stepper.value)] receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
        UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
        feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
        NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
        [feedbackTextView scrollRangeToVisible:bottom];
    }];
}

- (IBAction)alarmSliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.alarmPercentLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
}

- (IBAction)unablelockSliderValueChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    self.unableLockPercentLabel.text = [NSString stringWithFormat:@"%d", (int)slider.value];
}

- (IBAction)sendButtonTapped:(id)sender {
    [self.manager sendCommand:IOTCommandSetLowPowerCrisis
                       params:@[@([self.alarmPercentLabel.text intValue]), @([self.unableLockPercentLabel.text intValue])]
                receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
        UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
        feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
        NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
        [feedbackTextView scrollRangeToVisible:bottom];
    }];
}

#pragma mark - table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    IOTCommand command = (IOTCommand)row;
    
    if (command < IOTCommandAccelerationLevel) {
        [self.manager sendCommand:command params:nil receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
            UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
            feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
            NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
            [feedbackTextView scrollRangeToVisible:bottom];
        }];
    }
    
    if (command == IOTCommandResetDefaultServer) {
        [self.manager sendCommand:IOTCommandResetDefaultServer params:nil receivedBlock:^(NSDictionary * _Nonnull feedbackInfo) {
            UITextView *feedbackTextView = self.parentCtrl.feedbackTextView;
            feedbackTextView.text = [NSString stringWithFormat:@"%@\n%@", feedbackTextView.text, [feedbackInfo description]];
            NSRange bottom = NSMakeRange(feedbackTextView.text.length - 1, 1);
            [feedbackTextView scrollRangeToVisible:bottom];
        }];
    }
}

#pragma mark - iot ble manager delegate

- (void)iotBLEManagerActiveReportScooterInfos:(NSDictionary *)scooterInfos {
    UITextView *reportsTextView = self.parentCtrl.reportsTextView;
    reportsTextView.text = [NSString stringWithFormat:@"%@\n%@", reportsTextView.text, [scooterInfos description]];
    NSRange bottom = NSMakeRange(reportsTextView.text.length - 1, 1);
    [reportsTextView scrollRangeToVisible:bottom];
}

- (void)iotBLEManagerActiveReportErrorInfos:(NSDictionary *)errorInfos {
    UITextView *reportsTextView = self.parentCtrl.reportsTextView;
    reportsTextView.text = [NSString stringWithFormat:@"%@\n%@", reportsTextView.text, [errorInfos description]];
    NSRange bottom = NSMakeRange(reportsTextView.text.length - 1, 1);
    [reportsTextView scrollRangeToVisible:bottom];
}

@end
