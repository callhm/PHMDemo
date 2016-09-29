//
//  PHMUserNotifications.m
//  UserNotifications
//
//  Created by PHM on 9/26/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMUserNotifications.h"

static NSString *const categoryIdentifier = @"categoryIdentifier";

static NSString *const textInputActionIdentifier = @"textInputActionIdentifier";
static NSString *const normalActionIdentifier = @"normalActionIdentifier";
static NSString *const cancelActionIdentifier = @"cancelActionIdentifier";
@implementation PHMUserNotifications
- (instancetype)init {
    self = [super init];
    if (self) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    }
    return self;
}

- (void)dealloc{
    
}

#pragma mark Local Notifications
//申请本地通知和推送通知权限 Authorization
+ (void)requestAuthorization {
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //用户允许进行通知
            [PHMUserNotifications registerForRemoteNotifications];
        }
    }];
}

//获取通知设置
+ (void)getNotificationSettings {
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
}

//向APNs请求token Registration
+ (void)registerForRemoteNotifications {
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

//创建内容 Content 
- (UNMutableNotificationContent *)localNotificationContentTitle:(NSString *)title isActionable:(BOOL)actionable {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.subtitle = @"显示推送详情";
    content.body = @"显示推送主体内容";
    content.badge = @1;
    
    //Actionable Notifications
    if (actionable) {
        content.categoryIdentifier = categoryIdentifier;
    }
    return content;
}

//创建任务提醒触发器 Trigger
- (UNTimeIntervalNotificationTrigger *)timeIntervalNotificationTrigger {
  return  [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
}

//创建日历提醒触发器 Trigger
- (UNCalendarNotificationTrigger *)calendarNotificationTrigger {
    NSDateComponents *dataComponents = [[NSDateComponents alloc] init];
    return [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dataComponents repeats:NO];
}

//创建定位触发器 Trigger
- (UNLocationNotificationTrigger *)locationNotificationTrigger {
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    return [UNLocationNotificationTrigger triggerWithRegion:localNotification.region repeats:NO];
}

//创建请求并添加到发送中心 Schedule
- (void)addUserNotificationCenterRequestWithIdentifier:(NSString *)identifier
                                           withContent:(UNNotificationContent *)content
                                           withTrigger:(UNNotificationTrigger *)trigger {
    //申请本地通知和推送通知权限
    [PHMUserNotifications requestAuthorization];
    //创建请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    //添加到发送中心
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

#pragma mark  Notification Management
//未交付展示 移除
- (void)removePendingNotificationRequests{
    NSString *userNotificationIdentifier = @"request";
    //推送本地通知
    [self addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[self localNotificationContentTitle:@"本地推送 未交付展示 移除" isActionable:NO] withTrigger:[self timeIntervalNotificationTrigger]];
    
    [NSThread sleepForTimeInterval:0.0f];
    //移除
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[userNotificationIdentifier]];
}

//已交付展示 移除
- (void)removeDeliveredNotifications {
    NSString *userNotificationIdentifier = @"request";
    //推送本地通知
    [self addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[self localNotificationContentTitle:@"本地推送 已交付展示 移除" isActionable:NO] withTrigger:[self timeIntervalNotificationTrigger]];
    
    [NSThread sleepForTimeInterval:4.0f];
    
    //移除
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[userNotificationIdentifier]];
}

//已交付和未交付展示的更新
- (void)updateNotifications {
    NSString *userNotificationIdentifier = @"updateRequest";
    //推送本地通知
    [self addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[self localNotificationContentTitle:@"原本地推送" isActionable:NO] withTrigger:[self timeIntervalNotificationTrigger]];
    
    //修改延迟事件模拟交付状态
    [NSThread sleepForTimeInterval:4.0f];
    
    //更新本地通知
    [self addUserNotificationCenterRequestWithIdentifier:userNotificationIdentifier withContent:[self localNotificationContentTitle:@"本地推送 更新" isActionable:NO] withTrigger:[self timeIntervalNotificationTrigger]];
}

#pragma mark Actionable Notifications
//注册NotificationCategory
- (void)registerNotificationCategory {
    //添加TextInputNotificationAction，可输入文本的 action，设置Identifier来区分action
    UNTextInputNotificationAction *textInputAction = [UNTextInputNotificationAction actionWithIdentifier:textInputActionIdentifier title:@"TextInputAction" options:UNNotificationActionOptionForeground textInputButtonTitle:@"Send" textInputPlaceholder:@"textInputPlaceholder"];
    
    //添加普通操作NotificationAction，对应标准的按钮，设置Identifier来区分action
    UNNotificationAction *normalAction = [UNNotificationAction actionWithIdentifier:normalActionIdentifier title:@"NormalAction" options:UNNotificationActionOptionForeground];
    
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:cancelActionIdentifier title:@"CancelAction" options:UNNotificationActionOptionDestructive];
    
    //为category指定一个identifier，发送通知时在NotificationContent设置这个identifier，利用identifier区别发送的通知
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:categoryIdentifier actions:@[textInputAction, normalAction, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    
    //通知中心添加NotificationCategories
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories: [NSSet setWithObjects:category, nil]];
}

#pragma mark UNUserNotificationCenterDelegate
//应用内展示通知和icon上显示Badge
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionBadge);
}

//在与应用外展示的推送通知进行交互时被调用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)())completionHandler {
    NSLog(@"%@",response.notification.request.content.body);
    //操作指定category
    if ([categoryIdentifier isEqualToString:response.notification.request.content.categoryIdentifier]) {
        NSString *text = @"";
        //根据actionIdentifier区分Action
        if ([response.actionIdentifier isEqualToString:textInputActionIdentifier]) {
            UNTextInputNotificationResponse *textInputNotificationResponse =(UNTextInputNotificationResponse *)response;
            text = textInputNotificationResponse.userText;
        }else if([response.actionIdentifier isEqualToString:normalActionIdentifier]){
            text = @"normalAction";
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:text delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    completionHandler();
}
@end
