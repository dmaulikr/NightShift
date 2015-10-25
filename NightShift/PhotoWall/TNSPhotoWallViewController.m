//
//  TNSPhotoWallViewController.m
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import "TNSPhotoWallViewController.h"
#import "TNSShowDetailPhotoViewController.h"

#import "TNSDBCenter.h"

#define MAX_NUM 8

@interface TNSPhotoWallViewController ()

// 照片
@property (nonatomic, strong) NSMutableArray *array_photos;

@property (nonatomic, strong) NSMutableArray *array_btns;
@property (nonatomic, strong) NSMutableArray *array_imgViews;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation TNSPhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imgView.image = [UIImage imageNamed:@"img_bg"];
    [self.view addSubview:imgView];
    
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
            NSMutableArray *imagesFromDB = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                if (dic[@"img"]) {
                    [imagesFromDB addObject:dic[@"img"]];
                }
            }
            [self.array_photos addObjectsFromArray:imagesFromDB];
            [self reloadData];
        }
    }];
}

// 用作更新了array_photos后，照片的布局与相关逻辑
- (void)reloadData
{
    NSInteger num = MAX_NUM;
    if (self.array_btns.count == 0) {
        for (NSInteger i = 0; i < num; i++) {
            [self newBtnWithTag:i];
        }
    }
    
    for (NSInteger i = 0; i < self.array_btns.count; i++) {
        UIButton *btn  = self.array_btns[i];
        if (i < self.array_photos.count) {
            UIImage *image = self.array_photos[i];
            [btn setImage:image forState:UIControlStateNormal];
        } else {
            if (i == self.array_photos.count) {
                [btn setImage:[[UIImage imageNamed:@"icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
            } else {
                [btn setImage:nil forState:UIControlStateNormal];
                btn.enabled = NO;
            }
        }
    }
    
    UIButton *firstImgView = self.array_imgViews[0];
    [self.photoWallView bringSubviewToFront:firstImgView];
    
    for (UIImageView *imgView in self.array_imgViews) {
        CGRect frame = imgView.frame;
        imgView.center = CGPointMake(187.5, 335);
        [UIView animateWithDuration:2 delay:1 usingSpringWithDamping:0.4 initialSpringVelocity:0.4 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imgView.frame = frame;
        } completion:nil];
    }
}

- (UIButton *)newBtnWithTag:(NSInteger)tag
{
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.tag = tag;
    imgView.clipsToBounds = YES;
    imgView.userInteractionEnabled = YES;
    imgView.contentMode = UIViewContentModeScaleToFill;
    [self.photoWallView addSubview:imgView];
    [self.array_imgViews addObject:imgView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[[UIImage imageNamed:@"icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tag;
    [imgView addSubview:btn];
    [self.array_btns addObject:btn];
    
    CGPoint center = CGPointZero;
    CGFloat width = 0.0;
    switch (tag) {
        case 0:
            width = 130.0;
            center = CGPointMake(186, 334);
            break;
        case 1:
            width = 75.0;
            center = CGPointMake(144, 125);
            break;
        case 2:
            width = 80.0;
            center = CGPointMake(286, 195);
            break;
        case 3:
            width = 66.0;
            center = CGPointMake(320, 383);
            break;
        case 4:
            width = 85.0;
            center = CGPointMake(282, 509);
            break;
        case 5:
            width = 82.5;
            center = CGPointMake(106, 545);
            break;
        case 6:
            width = 67.5;
            center = CGPointMake(70, 414);
            break;
        case 7:
            width = 82.5;
            center = CGPointMake(62, 287);
            break;
        default:
            break;
    }
    
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_photos_%d", (int)tag]];
//    [imgView sizeToFit];
//    imgView.frame = CGRectInset(imgView.frame, -8, -8);
    imgView.frame = CGRectMake(0, 0, width, width);
    imgView.center = center;
    
    CGFloat width_btn = imgView.frame.size.width*0.8;
    btn.frame = CGRectMake(0, 0, width_btn, width_btn);
    btn.center = CGPointMake(imgView.frame.size.width/2, imgView.frame.size.height/2);
    btn.layer.cornerRadius = width_btn/2;
    btn.clipsToBounds = YES;
    
    return btn;
}

- (void)lastDay
{
    
}

- (void)nextDay
{
    
}

- (void)addPhoto:(UIButton *)btn
{
    if (btn.tag < self.array_photos.count) {
        // 进入详情页
        self.selectedIndex = btn.tag;
        [self performSegueWithIdentifier:@"ShowDetailPhoto" sender:self];
    } else {
        // 新增照片
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil
                                                        delegate:self
                                               cancelButtonTitle:@"取消" destructiveButtonTitle:nil
                                               otherButtonTitles:@"拍照", @"从手机相册", nil];
        [as showInView:self.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//相册
- (void)photoLib
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType               = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing            = YES;
    picker.delegate                 = self;
    [self presentViewController:picker animated:YES completion:nil];
}

//拍照
- (void)takePhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType               = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing            = YES;
    picker.delegate                 = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - delegate - action sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        // 从手机相册
        [self photoLib];
    }
}

#pragma mark imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    UIImage *editImage          = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.array_photos addObject:editImage];
    
    UIButton *btn = self.array_btns[self.array_photos.count-1];
    [btn setImage:editImage forState:UIControlStateNormal];
    [TNSDBCenter insertRecordIntoNightShiftPhotosTableWithImage:editImage takeTime:[NSDate millisecondsNumberSince1970]];
    
    if (self.array_photos.count < MAX_NUM) {
        UIButton *btn = self.array_btns[self.array_photos.count];
        [btn setImage:[[UIImage imageNamed:@"icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        btn.enabled = YES;
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - sb

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowDetailPhoto"]) {
        TNSShowDetailPhotoViewController *desvc = [segue destinationViewController];
        desvc.photo = self.array_photos[self.selectedIndex];
        UIImageView *imgView = self.array_imgViews[self.selectedIndex];
        desvc.fromRect = imgView.frame;
    }
}

@end

@implementation TNSPhotoWallView

@end