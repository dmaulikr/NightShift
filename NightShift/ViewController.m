//
//  ViewController.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import "ViewController.h"
#import "TNSAudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TNSAudioPlayer *player = [[TNSAudioPlayer alloc] init];
    [player getAudioInfoWithTag:@"民谣" success:^(NSArray *AudioIdentifierArray) {
        NSLog(@"%@",AudioIdentifierArray);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
