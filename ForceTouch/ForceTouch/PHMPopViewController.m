//
//  PHMPopViewController.m
//  ForceTouch
//
//  Created by PHM on 9/24/16.
//  Copyright © 2016 PHM. All rights reserved.
//

#import "PHMPopViewController.h"

@interface PHMPopViewController ()
@property (nonatomic, strong) UILabel *popLB;

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
    
    UIButton *dismissBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, [UIScreen mainScreen].bounds.size.width-60, 100)];
    [dismissBtn setTitle:@"Click Me" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnclick{
  [self dismissViewControllerAnimated:YES completion:^{
      
  }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
