//
//  MemeViewController.h
//  MemeApp
//
//  Created by Jeffrey Linwood on 4/17/14.
//  Copyright (c) 2014 Jeff Linwood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemeViewController : UIViewController  <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIView *memeView;
@property (strong, nonatomic) IBOutlet UIImageView *memeImageView;
@property (strong, nonatomic) IBOutlet UITextView *memeTextView;

@property (nonatomic, strong) UIImagePickerController *picker;

- (IBAction)shareOnTwitter:(id)sender;
- (IBAction)shareOnFacebook:(id)sender;

- (IBAction)takePhoto:(id)sender;
@end
