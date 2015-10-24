//
//  TNSPhotoWallViewController.m
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import "TNSPhotoWallViewController.h"

#import "TNSDBCenter.h"

@interface TNSPhotoWallViewController ()

// 照片
@property (nonatomic, strong) NSMutableArray *array_photos;

@property (nonatomic, strong) NSMutableArray *array_btns;
@property (nonatomic, strong) NSMutableArray *array_imgViews;

@end

@implementation TNSPhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.array_photos   = [NSMutableArray array];
    self.array_btns     = [NSMutableArray array];
    self.array_imgViews = [NSMutableArray array];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_left_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(lastDay)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_right_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(nextDay)];
    
    [self setupUI];
    
    [self loadPhotos];
}

- (void)setupUI
{
    TNSPhotoWallView *photoWallView = [[TNSPhotoWallView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    photoWallView.pagingEnabled = YES;
    [self.view addSubview:photoWallView];
    self.photoWallView = photoWallView;
    
    // 时间有限，只写一页
    [photoWallView setContentSize:CGSizeMake(self.view.bounds.size.width, 1)];
}

- (void)loadPhotos
{
    [TNSDBCenter selectRecordsOfTodayWhenOK:^(BOOL success, NSArray *array) {
        if (success) {
            [self.array_photos addObjectsFromArray:array];
            [self reloadData];
        }
    }];
}

// 用作更新了array_photos后，照片的布局与相关逻辑
- (void)reloadData
{
    NSInteger num = 8;
    if (self.array_btns.count == 0) {
        for (NSInteger i = 0; i < num; i++) {
            [self newBtnWithTag:i];
        }
    }
    
    for (NSInteger i = 0; i < self.array_photos.count; i++) {
        UIImage *image = self.array_photos[i];
        UIButton *btn  = self.array_btns[i];
        [btn setImage:image forState:UIControlStateNormal];
    }
}

- (UIButton *)newBtnWithTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.tag = tag;
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.photoWallView addSubview:imgView];
    [self.array_imgViews addObject:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.tag = tag;
    [imgView addSubview:btn];
    [self.array_btns addObject:btn];
    
    CGPoint center;
    switch (tag) {
        case 0:
            center = CGPointMake(187.5, 335);
            break;
        case 1:
            center = CGPointMake(146, 123);
            break;
        case 2:
            center = CGPointMake(290, 196);
            break;
        case 3:
            center = CGPointMake(324, 389);
            break;
        case 4:
            center = CGPointMake(286, 512);
            break;
        case 5:
            center = CGPointMake(107, 550);
            break;
        case 6:
            center = CGPointMake(70, 415);
            break;
        case 7:
            center = CGPointMake(64, 241);
            break;
        default:
            break;
    }
    
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_photo_%d", (int)tag]];
    [imgView sizeToFit];
    imgView.center = center;
    btn.center = CGPointMake(imgView.frame.size.width/2, imgView.frame.size.height/2);
    btn.center = center;
    
    return btn;
}

- (void)lastDay
{
    
}

- (void)nextDay
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation TNSPhotoWallView



@end