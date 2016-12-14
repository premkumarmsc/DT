//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

NSString *genderString;

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    genderString = @"Male";
    
    _lblMale.textColor = [UIColor blueColor];
    
   
    [self assignView:_viewNumber];
    [self assignView:_viewPassword];
    
   
    
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
    
    
    NSString *selectedState = [[NSUserDefaults standardUserDefaults]stringForKey:@"SELECTED_STATE"];
    
    if (_txtName.text.length ==0)
    {
        [ProgressHUD showError:@"Please enter Your Name"];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
    if (_numberFld.text.length ==0)
    {
        [ProgressHUD showError:@"Please enter email id"];
        
        // [_emailFld becomeFirstResponder];
    }
    else
    {
        
        if(![self NSStringIsValidEmail:_numberFld.text])
        {
            
            
            [ProgressHUD showError:@"Please enter valid email id"];
            
            // [_emailFld becomeFirstResponder];
        }
        else
        {
            if (_passwordFld.text.length ==0 )
            {
                
                //[hud hideAnimated:YES afterDelay:2];
                
                [ProgressHUD showError:@"Please enter password"];
                
                //[_uniqueIdFld becomeFirstResponder];
            }
            else
            {
                if (_txtPhone.text.length ==0 )
                {
                    
                    //[hud hideAnimated:YES afterDelay:2];
                    
                    [ProgressHUD showError:@"Please enter your Phone number"];
                    
                    //[_uniqueIdFld becomeFirstResponder];
                }
                else
                {
                    if (_txtDOB.text.length ==0 )
                    {
                        
                        //[hud hideAnimated:YES afterDelay:2];
                        
                        [ProgressHUD showError:@"Please select yout Date of birth"];
                        
                        //[_uniqueIdFld becomeFirstResponder];
                    }
                    else
                    {
                NSLog(@"Next");
                
                [ProgressHUD show:nil];
                
                        NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

                        
                //[MBProgressHUD show];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:_numberFld.text forKey:@"uemail"];
                [parameters setObject:_passwordFld.text forKey:@"upass"];
                        
                        
                        [parameters setObject:_txtName.text forKey:@"full_name"];
                        [parameters setObject:uniqueIdentifier forKey:@"device_id"];
                        
                        [parameters setObject:[NSString stringWithFormat:@"%@",selectedState] forKey:@"ustate"];
                        [parameters setObject:_txtPhone.text forKey:@"uphone"];
                        [parameters setObject:_txtDOB.text forKey:@"udob"];

                        [parameters setObject:genderString forKey:@"ugender"];

                
                NSLog(@"Params:%@",parameters);
                
                
                NSString *urlString=[NSString stringWithFormat:@"%@user_register",ApiBaseURL];
                
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
                        
                       
                        
                        ViewController *signObj =[[ViewController alloc]init];
                        [self.navigationController pushViewController:signObj animated:YES];
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    
                    [ProgressHUD showError:error.localizedDescription];
                    
                    
                }];
                }
                
                
                }
            }
            
        }
        
        
        
    }
    }

    
    
    
}

- (IBAction)clickBack:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
    
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
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dayName = [dateFormatter stringFromDate:selectedTime];
    
    
    
    long long milliseconds = (long long)([selectedTime timeIntervalSince1970]);
    
    
    // duedateTime = milliseconds;
    
    
    
    
    
    _txtDOB.text = [NSString stringWithFormat:@"%@",dayName];
    
    
    
}
- (IBAction)clickMale:(id)sender {
    
    _lblMale.textColor = [UIColor blueColor];
    _lblFemale.textColor = [UIColor grayColor];
    
    genderString = @"Male";
    
    _lblMale.textColor = [UIColor blueColor];
}

- (IBAction)clickFemale:(id)sender {
    
    _lblMale.textColor = [UIColor grayColor];
    _lblFemale.textColor = [UIColor blueColor];
    
    genderString = @"Female";
    
    //_lblMale.textColor = [UIColor blueColor];
}


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
