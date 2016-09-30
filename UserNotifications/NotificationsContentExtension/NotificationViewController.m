//
//  NotificationViewController.m
//  NotificationsContentExtension
//
//  Created by PHM on 9/30/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>


static NSString *const textInputActionIdentifier = @"textInputActionIdentifier";
static NSString *const normalActionIdentifier = @"normalActionIdentifier";
static NSString *const cancelActionIdentifier = @"cancelActionIdentifier";
@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

//设置Notification Content
- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
}

//在ContentExtension中操作Action后调用方法，其中completion()填写操作Action后反馈
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response
                     completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{
    if ([response.actionIdentifier isEqualToString:textInputActionIdentifier]) {
        if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
            self.label.textColor = [UIColor blueColor];
        }

    }else if ([response.actionIdentifier isEqualToString:normalActionIdentifier]){
        self.label.textColor = [UIColor redColor];
    }
    completion(UNNotificationContentExtensionResponseOptionDismiss);
}

@end
