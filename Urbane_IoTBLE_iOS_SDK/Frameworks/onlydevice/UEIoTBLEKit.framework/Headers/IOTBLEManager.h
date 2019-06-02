//
//  IOTBLEManager.h
//  IOT-DEMO
//
//  Created by janlionly<jan_ron@qq.com> on 2019/5/8.
//  Copyright © 2019 Urbane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IOTCommand) {
    // control Instruction
    IOTCommandOpenLock = 0,
    IOTCommandCloseLock,
    IOTCommandOpenLeadingLed,
    IOTCommandCloseLeadingLed,
    IOTCommandOpenTrailLed,
    IOTCommandCloseTrailLed,
    IOTCommandOpenBottomLed,
    IOTCommandCloseBottomLed,
    IOTCommandOpenAllLed,
    IOTCommandCloseAllLed,
    IOTCommandControllerState,
    IOTCommandOpenNonzero,
    IOTCommandCloseNonzero,
    IOTCommandOpenCruise,
    IOTCommandCloseCruise,
    IOTCommandUnlockWheelHub,
    IOTCommandLockWheelHub,
    IOTCommandUnlockBattery,
    IOTCommandLockBattery,
    IOTCommandAccelerationLevel,    // param(int): 0: very low, 1: low, 2: mid, 3: high
    IOTCommandSpeedLimiting,        // param(int): 0~30 (unit: km/h)
    
    // config instruction
    IOTCommandSetWorkMode,          // param(int): 0: normal mode, 1: transform mode(2G closed)
    IOTCommandResetDefaultServer,
    IOTCommandSetGSensorLevel,      // param(int): 0: close, 1:sensitivity high, 2:sensitivity mid, 3: sensitivity low
    IOTCommandSetLowPowerCrisis     // params(int): AlarmCrisis percent and UnableLockCrisis percent (0~100)
};

/** send command feedback result keys: */ //start

// 0: close leading led, 1: open leading led, 2: close trail led, 3: open trail led,
// 4: close bottom led, 5: open bottom led, 6: close all leds, 7: open all leds
FOUNDATION_EXPORT NSString *const IOTCommandLedStateKey;

FOUNDATION_EXPORT NSString *const IOTCommandLockStateKey;           // 0: unlock, 1: lock
FOUNDATION_EXPORT NSString *const IOTCommandNonzeroStateKey;        // 0: turn off nonzero-firing，1: turn on nonzero-firing
FOUNDATION_EXPORT NSString *const IOTCommandCruiseStateKey;         // 0: turn off cruise, 1: turn on cruise
FOUNDATION_EXPORT NSString *const IOTCommandAccelerationLevelKey;   // 0: very low, 1:low, 2: mid, 3: high
FOUNDATION_EXPORT NSString *const IOTCommandSpeedLimitingKey;       // 0~30: speed (unit: km/h)
FOUNDATION_EXPORT NSString *const IOTCommandWheelHubStateKey;       // 0: unlock, 1: lock
FOUNDATION_EXPORT NSString *const IOTCommandBatteryStateKey;        // 0: unlock, 1: lock

FOUNDATION_EXPORT NSString *const IOTCommandControllerPowerStateKey;        // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerLockStateKey;         // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerLeadTrailLedStateKey; // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerNonezeroStateKey;     // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerCruiseStateKey;       // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerAlarmStateKey;        // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerAccelerationLevelKey; // 0: very low, 1:low, 2: mid, 3: high
FOUNDATION_EXPORT NSString *const IOTCommandControllerLedBandStateKey;      // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerTrailLedStateKey;     // 0: off, 1: on
FOUNDATION_EXPORT NSString *const IOTCommandControllerSpeedLimitingKey;     // speed between in 0~30

FOUNDATION_EXPORT NSString *const IOTCommandWorkModeKey;                 // 0: success
FOUNDATION_EXPORT NSString *const IOTCommandResetDefaultServerKey;       // 0: success
FOUNDATION_EXPORT NSString *const IOTCommandGSensorLevelKey;             // 0: success
FOUNDATION_EXPORT NSString *const IOTCommandSetLowPowerCrisisKey;        // 0: success
// end

// Code: 0: no exception, 1: exist exception
FOUNDATION_EXPORT NSString *const IOTCommandUsbExceptionCode;
FOUNDATION_EXPORT NSString *const IOTCommandControllerAccExceptionCode;
FOUNDATION_EXPORT NSString *const IOTCommandGSensorExceptionCode;
FOUNDATION_EXPORT NSString *const IOTCommandEepromExceptionCode;
FOUNDATION_EXPORT NSString *const IOTCommandBmsExceptionCode;
FOUNDATION_EXPORT NSString *const IOTCommandControllerCommunicationExceptionCode;

// scooter info
FOUNDATION_EXPORT NSString *const IOTCommandScooterNameKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterRSSIKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterMACAddressKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterCurrentSpeedKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterCurrentRidingDistanceKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterBatteryPercentKey;
FOUNDATION_EXPORT NSString *const IOTCommandScooterBatterySOHKey;


// battery states
FOUNDATION_EXPORT NSString *const IOTCommandBatteryChargingStateKey;                    // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryChargeOverCurrentProtectionKey;      // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryDischargingStateKey;                 // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryDischargeOverCurrentProtectionKey;   // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryOvervoltageWarningKey;               // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryOvervoltageProtectionKey;            // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryLowVoltageWarningKey;                // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryLowVoltageProtectionKey;             // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryHighTempWarningKey;                  // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryHighTempProtectionKey;               // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryLowTempWarningKey;                   // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryLowTempProtectionKey;                // 0: no, 1: yes
FOUNDATION_EXPORT NSString *const IOTCommandBatteryBMSWorkModeKey;  // 0: init, 1: poweroff, 2: sleep, 3: standby, 4: ride 5: charge 6: invalid


@protocol IOTBLEManagerDelegate <NSObject>

- (void)iotBLEManagerActiveReportScooterInfos:(NSDictionary *)scooterInfos;  // active read scooter infos
- (void)iotBLEManagerActiveReportErrorInfos:(NSDictionary *)errorInfos;      // active read error infos

@end

@interface IOTBLEManager : NSObject

+ (instancetype)sharedIOTBLEManager;

@property (nonatomic, weak) id<IOTBLEManagerDelegate> delegate;

- (void)startScanningDidDiscoverScootersBlock:(void(^)(NSArray <NSDictionary *>* _Nullable))scooterInfosBlock;  // scanning all scooters
- (void)cancelScan;     // cancel scan scooters
- (void)connectScooterWithMACAddress:(NSString *)macAddress completion:(void(^)(BOOL))completion;    // connect an assigned scooter
- (void)disconnectScooterWithMACAddress:(NSString *)macAddress completion:(void(^)(void))completion; // disconnect an assigned scooter
- (void)disconnectAllScootersWithCompletion:(void(^)(void))completion;
- (void)sendCommand:(IOTCommand)command params:(nullable NSArray <NSNumber *> *)params receivedBlock:(nullable void(^)(NSDictionary *))receivedBlock;

@end

NS_ASSUME_NONNULL_END
