//
//  PHMPeekViewController.m
//  ForceTouch
//
//  Created by PHM on 9/24/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMPeekViewController.h"
#import "PHMPopViewController.h"

@interface PHMPeekViewController ()

@end

@implementation PHMPeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems{
    //生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 selected");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Action 2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *tap = [UIPreviewAction actionWithTitle:@"Pop View" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        PHMPopViewController *popViewController = [[PHMPopViewController alloc] init];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:popViewController animated:YES completion:nil];
    }];
    
    //生成Action Group
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Preview Action Group" style:UIPreviewActionStyleDefault actions:@[action1, action2]];

    //生成Action Group
    return @[group1,tap];
}
@end
