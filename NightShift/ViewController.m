//
//  ViewController.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/24.
//
//

#import "ViewController.h"
#import <FSAudioStream.h>

@interface ViewController ()
@property (nonatomic, strong) FSAudioStream *stream;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stream = [[FSAudioStream alloc] initWithUrl:[NSURL URLWithString:@"http://file.qianqian.com//data2/music/18874628/18874628.mp3?xcode=e5b6e8a9cc0ddfe705ffee87c3adb48c&src="]];
    [self.stream setVolume:0.5];
    [self.stream play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
