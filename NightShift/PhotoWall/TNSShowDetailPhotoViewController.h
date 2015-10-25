//
//  TNSShowDetailPhotoViewController.h
//  NightShift
//
//  Created by 陈颖鹏 on 15/10/25.
//
//

#import <UIKit/UIKit.h>

@interface TNSShowDetailPhotoViewController : UIViewController

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, assign) CGRect fromRect;

@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end
