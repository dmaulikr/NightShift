//
//  TNSTabbarController.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import "TNSTabbarController.h"

@interface TNSTabbarController ()

@end

@implementation TNSTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化操作
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_bg"]];
    imgView.frame = [[UIScreen mainScreen] bounds];
    [self.view insertSubview:imgView atIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
