//
//  TNSPlayViewController.m
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/25.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import "TNSPlayViewController.h"
#import "TNSPlayItemView.h"

@interface TNSPlayViewController ()

@property (nonatomic) TNSPlayItemView *playItem;


@end

@implementation TNSPlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [self.playItem startAnimation];
    [self.playItem startMotion];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.playItem stopMotion];
    [self.playItem reset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playItem = [[TNSPlayItemView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 49 - 64)];
    [self.view addSubview:self.playItem];


    // Do any additional setup after loading the view.
}
- (IBAction)clearPressed:(UIBarButtonItem *)sender {
    [self.playItem removeAllBoundary];
}

- (IBAction)addPressed:(id)sender {
    [self.playItem addAPlayItem];
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
