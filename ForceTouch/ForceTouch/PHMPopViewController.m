//
//  PHMPopViewController.m
//  ForceTouch
//
//  Created by PHM on 9/24/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMPopViewController.h"

@interface PHMPopViewController ()<UIPreviewInteractionDelegate>
@property (nonatomic, strong) UILabel *popLB;
@property (nonatomic, strong) UIPreviewInteraction *previewInteraction;
@end

@implementation PHMPopViewController
- (UILabel *)popLB
{
    if (!_popLB) {
        UILabel *popLB = [[UILabel alloc] initWithFrame:self.view.bounds];
        popLB.userInteractionEnabled = YES;
        popLB.text = @"PopView";
        popLB.backgroundColor = [UIColor blackColor];
        popLB.textColor = [UIColor whiteColor];
        popLB.font = [UIFont systemFontOfSize:18];
        popLB.textAlignment = NSTextAlignmentCenter;
        _popLB = popLB;
    }
    return _popLB;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.popLB];
    
    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, [UIScreen mainScreen].bounds.size.width-60, 100)];
    [dismissBtn setTitle:@"Dismiss VIew" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
    
    
    //
    
    _previewInteraction = [[UIPreviewInteraction alloc] initWithView:self.popLB];
    _previewInteraction.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnclick{
  [self dismissViewControllerAnimated:YES completion:^{
      
  }];
}


#pragma mark UIPreviewInteractionDelegate
//开始3D Touch交互
- (BOOL)previewInteractionShouldBegin:(UIPreviewInteraction *)previewInteraction UIKIT_AVAILABLE_IOS_ONLY(10_0){
    return YES;
}

//transitionProgress 范围  0 － 1
- (void)previewInteraction:(UIPreviewInteraction *)previewInteraction
didUpdatePreviewTransition:(CGFloat)transitionProgress
                     ended:(BOOL)ended UIKIT_AVAILABLE_IOS_ONLY(10_0) {
    
    if(ended){
        NSLog(@"didUpdatePreviewended");
        _popLB.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:1];
        _popLB.textColor = [UIColor whiteColor];
    }else{
        _popLB.backgroundColor = [UIColor colorWithRed:255*transitionProgress/255 green:0 blue:0 alpha:1];
    }
}

//transitionProgress 范围  0 － 1
- (void)previewInteraction:(UIPreviewInteraction *)previewInteraction
 didUpdateCommitTransition:(CGFloat)transitionProgress
                     ended:(BOOL)ended UIKIT_AVAILABLE_IOS_ONLY(10_0){
    if(ended){
        NSLog(@"didUpdateCommitended");
        _popLB.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
        _popLB.textColor = [UIColor blackColor];
    }else{
        _popLB.backgroundColor = [UIColor colorWithRed:255 green:0 blue:255*transitionProgress/255 alpha:1];
    }
}

//取消3D Touch交互
- (void)previewInteractionDidCancel:(UIPreviewInteraction *)previewInteraction UIKIT_AVAILABLE_IOS_ONLY(10_0) {
    _popLB.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    _popLB.textColor = [UIColor whiteColor];

}



@end
