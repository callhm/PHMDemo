//
//  PHMUserNotifications.h
//  UserNotifications
//
//  Created by PHM on 9/26/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
@interface PHMUserNotifications : NSObject<UNUserNotificationCenterDelegate>
+ (void)requestAuthorization;
+ (void)registerForRemoteNotifications;
+ (void)getNotificationSettings;

- (UNMutableNotificationContent *)localNotificationContentTitle:(NSString *)title isActionable:(BOOL)actionable;
- (UNTimeIntervalNotificationTrigger *)timeIntervalNotificationTrigger;
- (UNCalendarNotificationTrigger *)calendarNotificationTrigger;
- (UNLocationNotificationTrigger *)locationNotificationTrigger;

//创建通知
- (void)addUserNotificationCenterRequestWithIdentifier:(NSString *)identifier withContent:(UNNotificationContent *)content withTrigger:(UNNotificationTrigger *)trigger;

//Notification Management
- (void)removePendingNotificationRequests;
- (void)removeDeliveredNotifications;
- (void)updateNotifications;

//Actionable Notifications
- (void)registerNotificationCategory;




@end
