//
//  CommandListViewController.h
//  ScooterDemo
//
//  Created by janlionly<jan_ron@qq.com> on 2019/5/31.
//  Copyright © 2019 Urbane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScooterViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommandListViewController : UITableViewController

@property (weak, nonatomic) ScooterViewController *parentCtrl;

@end

NS_ASSUME_NONNULL_END
