//
//  ViewController.m
//  UserNotifications
//
//  Created by PHM on 9/26/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "ViewController.h"
#import "PHMUserNotifications.h"
#define sysVer [[[UIDevice currentDevice] systemVersion] floatValue]
static NSString *cellIdentifler = @"cellIdentifler";

@interface ViewController ()
@property (nonatomic, strong) NSArray *notifications;
@property (nonatomic, strong) PHMUserNotifications *userNotifications;

@end

@implementation ViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    _userNotifications = [[PHMUserNotifications alloc] init];
    if (sysVer >= 10.0) {
        _notifications = @[@"发送任务提醒Notification",@"已交付Notification 进行更新",@"发送可操作的Notification"];
    }else{
        _notifications =  @[@"用iOS 10系统进行测试"];
    }
    //Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return _notifications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifler];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifler];
    }
    cell.textLabel.text = _notifications[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
//点击行
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0://发送任务提醒Notification 2秒后发送信息
        {
            NSString *userNotificationIdentifier = @"defultNotification";
            [_userNotifications addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[_userNotifications localNotificationContentTitle:@"任务提醒 本地推送" isActionable:NO] withTrigger:[_userNotifications timeIntervalNotificationTrigger]];
        }
            break;
        case 1://发送可操作的Notification 2秒后发送信息 4秒后发送信息
        {
            [_userNotifications updateNotifications];
        }
            break;
        case 2://发送可操作的Notification 2秒后发送信息
        {
            [_userNotifications registerNotificationCategory];
            NSString *userNotificationIdentifier = @"defultNotification";
            [_userNotifications addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[_userNotifications localNotificationContentTitle:@"可操作的 本地推送" isActionable:YES] withTrigger:[_userNotifications timeIntervalNotificationTrigger]];
        }
            break;
        default:
            break;
    }
}

@end
