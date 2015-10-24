//
//  ViewController.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import "ViewController.h"
#import <FSAudioStream.h>
#import "TNSPlayerView.h"

@interface ViewController ()
@property (nonatomic, strong) TNSPlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playerView = [[TNSPlayerView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.playerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
