//
//  TNSPhotoWallViewController.h
//  SFH_test
//
//  Created by 陈颖鹏 on 15/10/24.
//  Copyright © 2015年 陈颖鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TNSPhotoWallView;

@interface TNSPhotoWallViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// 可滑动的照片墙
@property (nonatomic, weak) TNSPhotoWallView *photoWallView;

@end

@interface TNSPhotoWallView : UIScrollView

@end
