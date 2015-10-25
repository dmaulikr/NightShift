//
//  TNSShowDetailPhotoViewController.m
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/25.
//
//

#import "TNSShowDetailPhotoViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITextView (Override)

- (void)drawRect:(CGRect)rect
{
    CGFloat width  = rect.size.width;
    CGFloat height = rect.size.height;
    
    CGFloat lineWidth = 1.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    CGContextMoveToPoint(context, lineWidth, height-height/4);
    CGContextAddLineToPoint(context, lineWidth, height-1);
    CGContextAddLineToPoint(context, width-lineWidth, height-1);
    CGContextAddLineToPoint(context, width-lineWidth, height-height/4);
    
    CGContextStrokePath(context);
}

@end

@interface TNSShowDetailPhotoViewController ()

@end

@implementation TNSShowDetailPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.imgView.image = self.photo;
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
