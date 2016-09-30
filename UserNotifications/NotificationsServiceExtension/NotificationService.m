//
//  NotificationService.m
//  NotificationsServiceExtension
//
//  Created by PHM on 9/29/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
//接收到的推送可以在这里进行加工处理，最终的内容给ContentHandler显示在前台
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    //回调新的 content
    self.contentHandler(self.bestAttemptContent);
}

//如果在获得的一小段运行时间即将结束的时候，如果仍然没有成功的传入内容，会走到这个方法，这个方法默认传递原始的推送内容，也可以在这里传肯定不会出错的内容。
- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
