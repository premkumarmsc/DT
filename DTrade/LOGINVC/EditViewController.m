//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    
   
    [self assignView:_viewNumber];
    [self assignView:_viewPassword];
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATAS"];
    
    NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    NSLog(@"Get Data:%@",getUserData);
    
    
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2;
    _imgUser.clipsToBounds = true;
    
    
    
    
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[getUserData valueForKey:@"thumb_image"]];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    
    
    
    _txtName.text = [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"name"]];
    
    _numberFld.text =  [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"emailid"]];;
    
    
    _txtAddress.text = [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"address"]];
    
    _txtPhone.text = [NSString stringWithFormat:@"Hi, %@",[getUserData valueForKey:@"phone_no"]];
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)assignView:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loginBtn:(id)sender {
    
    
    if([_numberFld.text isEqualToString:@""])
    {
        
        NSString *test = NSLocalizedString(@"VALID_MOBILE", @"Message");
        
        
        
        
        [ProgressHUD showError:test];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        
        if([_passwordFld.text isEqualToString:@""])
        {
            
            [ProgressHUD showError:NSLocalizedString(@"VALID_PASSWORD", @"Message")];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
            
            [self login];
            
        }
        
        
        
        
    }
    
    
}

-(void)login
{
    
    
    
    /*
    //NSString *uniqueString =  [[NSUserDefaults standardUserDefaults]stringForKey:@"UNIQUE_KEY"];
    
    // [self forgot];
    
    
    [ProgressHUD show:nil];
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:_numberFld.text forKey:@"userId"];
    [parameters setObject:_passwordFld.text forKey:@"password"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@/Login",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=1)
        {
            [ProgressHUD showError:[NSString stringWithFormat:@"%@",[JSON valueForKey:@"message"]]];
        }
        else
        {
            
            NSString *mobileNo=[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"userId"]];
            
            
            
            
            [[NSUserDefaults standardUserDefaults]setObject:mobileNo forKey:@"USER_ID_MAIN"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"name"]] forKey:@"USER_NAME"];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"emailId"]] forKey:@"USER_EMAIl"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[JSON valueForKeyPath:@"gender"]] forKey:@"USER_GENDER"];
            
           // DashboardViewController *signObj =[[DashboardViewController alloc]init];
           // [self.navigationController pushViewController:signObj animated:YES];
            
            [ProgressHUD dismiss];
            
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
     */
    
}



- (IBAction)forgotPasswordBtn:(id)sender
{
    
    ForgotViewController *signObj =[[ForgotViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
    
}

- (IBAction)facebookBtn:(id)sender {
}

- (IBAction)clickSignUp:(id)sender {
    
    /*
    RegisterViewController *signObj =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
     */
    
}

- (IBAction)clickBack:(id)sender {
    
    //[MBProgressHUD show];
    
    
    NSString *userPASS= [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_PASS_MAIN"];
    

    //NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATAS"];
    
    NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    
     NSString *userEmail =  [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"emailid"]];;
    

    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:userEmail forKey:@"useremail"];
    [parameters setObject:userPASS forKey:@"userpass"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@user_login",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=200)
        {
            
            
           // [ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            
           //   [ProgressHUD dismiss];
            
            
            NSLog(@"ID:%@",[JSON valueForKeyPath:@"user_details.id"][0]);
            
            [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_details.id"][0] forKey:@"USER_ID_MAIN"];
            
            
           // [[NSUserDefaults standardUserDefaults]setObject:_passwordFld.text forKey:@"USER_PASS_MAIN"];
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[JSON valueForKeyPath:@"user_details"][0]];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"USER_DATAS"];
            
            
        }
        
        
         [self.navigationController popViewControllerAnimated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
       // [ProgressHUD showError:error.localizedDescription];
        
         [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    
    
    
    
    
}
- (IBAction)clickDOB:(id)sender {
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select Your DOB" datePickerMode:UIDatePickerModeDate selectedDate:[NSDate date] minimumDate:nil maximumDate:[NSDate date] target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = 5;
    [datePicker showActionSheetPicker];
    
    
}

- (NSDate *)logicalOneYearAgo:(NSDate *)from {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-5];
    
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
    
}

- (NSDate *)logicalOneYearAgo1:(NSDate *)from {
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:-100];
    
    return [gregorian dateByAddingComponents:offsetComponents toDate:from options:0];
    
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dayName = [dateFormatter stringFromDate:selectedTime];
    
    
    
    long long milliseconds = (long long)([selectedTime timeIntervalSince1970]);
    
    
    // duedateTime = milliseconds;
    
    
    
    
    
    _txtDOB.text = [NSString stringWithFormat:@"%@",dayName];
    
    
    
}
- (IBAction)clickMale:(id)sender {
    
    _lblMale.textColor = [UIColor blueColor];
    _lblFemale.textColor = [UIColor grayColor];
}

- (IBAction)clickFemale:(id)sender {
    
    _lblMale.textColor = [UIColor grayColor];
    _lblFemale.textColor = [UIColor blueColor];
}
- (IBAction)clickUpdate:(id)sender {
    
   NSString *base64String =  [self base64String:[self imageWithImageSimple:_imgUser.image scaledToSize:CGSizeMake(300, 300)]];
    
    //NSLog(@"Base 64 Str:%@",base64String);
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    
    [ProgressHUD show:nil];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:base64String forKey:@"base64img"];
    [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"id"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@edit_user_profile_photo",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=200)
        {
            
            
            [ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            
            //[ProgressHUD dismiss];
            
            [ProgressHUD showSuccess:[JSON valueForKey:@"message"]];
            
            
            //[self clickBack:nil];
        }
        
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    


}

- (NSString *)base64String : (UIImage *)img
{
    return [UIImagePNGRepresentation(img) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (IBAction)clickSubmit:(id)sender {
    
    
    [ProgressHUD show:nil];
    
    
    //[MBProgressHUD show];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:_numberFld.text forKey:@"email"];
   // [parameters setObject:_passwordFld.text forKey:@"upass"];
    
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"id"];
    

    
    [parameters setObject:_txtName.text forKey:@"fullname"];
    //[parameters setObject:uniqueIdentifier forKey:@"device_id"];
    
   // [parameters setObject:[NSString stringWithFormat:@"%@",selectedState] forKey:@"ustate"];
    [parameters setObject:_txtPhone.text forKey:@"phoneno"];
    [parameters setObject:_txtAddress.text forKey:@"addressinfo"];
    
   // [parameters setObject:genderString forKey:@"email"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@profile_edit",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=200)
        {
            
            
            [ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            
            //[ProgressHUD dismiss];
            
            
            [ProgressHUD showSuccess:[JSON valueForKey:@"message"]];
                     
            
        }
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];


}

- (IBAction)clickImage:(id)sender {
    NSString *actionSheetTitle = @"Where do you want to take the image from?"; //Action Sheet Title
    // NSString *destructiveTitle = @"Destructive Button"; //Action Sheet Button Titles
    NSString *other1 = @"Camera";
    NSString *other2 = @"Album";
    
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2,  nil];
    [actionSheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    //tagnew = 0;
    
    if (buttonIndex==0)
    {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            
            
            
            
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
            
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            [picker setDelegate:self];
            
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setShowsCameraControls:YES];
            [picker setAllowsEditing:NO];
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert-360" message:@"The device does not have camera" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            // [alert release];
        }
        
    }
    else  if (buttonIndex==1)
    {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
    
}

/*
 1.Splash
 2. Login
 3. Forgot
 4. Register
 5. OTP
 6. Home page Map
 7. Drawer
 */



NSString *lettersnew = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
-(NSString *) randomStringWithLength: (int) len {
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [lettersnew characterAtIndex: arc4random_uniform([lettersnew length])]];
    }
    
    return randomString;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    UIImage *image;
    
    if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
    {
        ////(@"CAMERA");
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
    }
    else
    {
        ////(@"ALBUM");
        
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];//获取图片
        
        
        
        
        
    }
    
    
    
    
    
    _imgUser.image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    
    //_newImage.image = [self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)];
    
    
    //[_btnImage setImage:image forState:UIControlStateNormal];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self dismissModalViewControllerAnimated:YES];
    
    
    
    
}


-(UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //[viewSlide shouldAutoShow:YES];
    [picker dismissModalViewControllerAnimated:YES];
}


@end
