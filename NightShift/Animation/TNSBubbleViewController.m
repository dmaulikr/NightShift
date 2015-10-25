//
//  TNSBubbleViewController.m
//  TNSBubbleViewController
//
//  Created by Bers on 15/10/24.
//  Copyright © 2015年 Bers. All rights reserved.
//

#import "TNSBubbleViewController.h"
#import "TNSBubbleManager.h"
#import "TNSPlayerView.h"
#import "TNSMediaProtocolImpl.h"

@interface TNSBubbleViewController ()

@property (nonatomic) TNSBubbleManager *bubbleManager;
@property (nonatomic, strong) TNSMediaProtocolImpl *provider;

@end

@implementation TNSBubbleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block NSArray<NSString*> *titles = @[@"_(:з」∠)_", @"（¯﹃¯）", @"╭(′▽`)╯", @"(╯-╰)/ ", @"╰(￣▽￣)╮", @"(╯▽╰)"];
    __block NSArray<NSString*> *urls;
    self.provider = [[TNSMediaProtocolImpl alloc] init];
    __weak TNSBubbleViewController *wself = self;
    [self.provider getMediaInfoWithSuccessBlock:^(NSArray *IdentifierArray) {;
        urls = [IdentifierArray copy];
        wself.bubbleManager = [[TNSBubbleManager alloc] initWithTitles:titles urls:urls];
        [wself.bubbleManager addBubblesToView:wself.view];
        wself.automaticallyAdjustsScrollViewInsets = NO;
        TNSPlayerView *playerView = [[TNSPlayerView alloc] initWithFrame:CGRectMake(0, 64, wself.view.frame.size.width, wself.view.frame.size.height - 64 - 49)];
        [wself.view addSubview:playerView];
        [playerView setAlpha:0.0];
        
        [wself.bubbleManager setPlayerView:playerView];
    }];
    
    // Do any additional setup after loading the view.
}

- (IBAction)rightBtnPressed:(id)sender {
    if (![self.provider isLoading]) {
        [self.provider refreshWithSuccessBlock:^(NSArray *AudioIdentifierArray) {
            [self.bubbleManager resetBubblesWithTitles:
  @[ @"(╯-╰)/ ", @"(╯▽╰)", @"（¯﹃¯）", @"╭(′▽`)╯", @"_(:з」∠)_",  @"╰(￣▽￣)╮"]
                                         subtitles:nil urls:AudioIdentifierArray];
        }];
    }

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
