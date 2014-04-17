//
//  MemeViewController.m
//  MemeApp
//
//  Created by Jeffrey Linwood on 4/17/14.
//  Copyright (c) 2014 Jeff Linwood. All rights reserved.
//

#import "MemeViewController.h"

#import <Social/Social.h>

@interface MemeViewController ()

@end

@implementation MemeViewController

- (void) hideKeyboard {
    [self.view endEditing:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //any taps outside the keyboard will dismiss the keyboard
    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    //load the image picker
    self.picker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    } else {
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    self.picker.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)createMemeImage {
    
    UIGraphicsBeginImageContext(self.memeView.bounds.size);
    [self.memeView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *memeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return memeImage;
}


- (IBAction)shareOnTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *vc = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
        [vc setInitialText:@"From the Meme App"];
        [vc addImage:[self createMemeImage]];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Twitter Login Required" message:@"You will need to sign into Twitter in the Settings App to share this on Twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
    }
}

- (IBAction)shareOnFacebook:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *vc = [SLComposeViewController
                                       composeViewControllerForServiceType:SLServiceTypeFacebook];
        [vc setInitialText:@"From the Meme App"];
        [vc addImage:[self createMemeImage]];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Facebook Login Required" message:@"You will need to sign into Facebook in the Settings App to share this on Facebook" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
    }
}

- (IBAction)takePhoto:(id)sender {
    [self presentViewController:self.picker animated:YES completion:nil];
}




#pragma mark ImagePickerControllerDelegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.memeImageView.image = info[UIImagePickerControllerOriginalImage];
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
