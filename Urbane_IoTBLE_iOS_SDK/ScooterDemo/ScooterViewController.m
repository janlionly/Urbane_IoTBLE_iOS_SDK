//
//  ScooterViewController.m
//  ScooterDemo
//
//  Created by LAIZHIJIAN on 2019/5/31.
//  Copyright © 2019 janlionly<jan_ron@qq.com>. All rights reserved.
//

#import "ScooterViewController.h"
#import "CommandListViewController.h"

@interface ScooterViewController ()


@end

@implementation ScooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"EmbedSegue"]) {
        CommandListViewController *target = (CommandListViewController *)segue.destinationViewController;
        target.parentCtrl = self;
    }
}

@end
