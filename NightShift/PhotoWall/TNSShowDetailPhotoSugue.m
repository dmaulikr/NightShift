//
//  TNSShowDetailPhotoSugue.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/25.
//
//

#import "TNSShowDetailPhotoSugue.h"

#import "TNSShowDetailPhotoViewController.h"

@implementation TNSShowDetailPhotoSugue

- (void)perform
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIViewController *sourcevc = [self sourceViewController];
    TNSShowDetailPhotoViewController *destinatevc = [self destinationViewController];
    
    
    destinatevc.view.frame = screenBounds;
    [sourcevc.view addSubview:destinatevc.view];
    destinatevc.imgView.transform = CGAffineTransformMakeScale(destinatevc.fromRect.size.width/destinatevc.imgView.frame.size.width, destinatevc.fromRect.size.height/destinatevc.imgView.frame.size.height);
    destinatevc.imgView.transform = CGAffineTransformTranslate(destinatevc.imgView.transform, destinatevc.fromRect.origin.x+destinatevc.fromRect.size.width-destinatevc.imgView.center.x, destinatevc.fromRect.origin.y+destinatevc.fromRect.size.height-destinatevc.imgView.center.y);

    [UIView animateWithDuration:0.4 animations:^{
        destinatevc.imgView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [destinatevc.view removeFromSuperview];
        [sourcevc.navigationController pushViewController:destinatevc animated:NO];
    }];
}

@end
