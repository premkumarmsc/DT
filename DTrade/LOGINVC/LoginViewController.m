//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    
    if( [[[NSUserDefaults standardUserDefaults]stringForKey:@"LANGUAGE"] isEqualToString:@"EN"])
    {
        
    }
    else
    {
        
    }
    
    
    
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"].length == 0)
    {
        
    }
    else
    {
       
            
            /*
            DashboardViewController *dashObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:NO];
             */
            
        
        
        
    }
   
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
    
    
    
   // DashboardViewController *signObj =[[DashboardViewController alloc]init];
   // [self.navigationController pushViewController:signObj animated:YES];
    
    
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
                NSLog(@"Next");
                
                [ProgressHUD show:nil];
                
                //[MBProgressHUD show];
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:_numberFld.text forKey:@"useremail"];
                [parameters setObject:_passwordFld.text forKey:@"userpass"];
                
                
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
                        
                        
                        [ProgressHUD showError:[JSON valueForKey:@"message"]];
                    }
                    else
                    {
                        
                        [ProgressHUD dismiss];
                        
                        
                        NSLog(@"ID:%@",[JSON valueForKeyPath:@"user_details.id"][0]);
                        
                        [[NSUserDefaults standardUserDefaults]setObject:[JSON valueForKeyPath:@"user_details.id"][0] forKey:@"USER_ID_MAIN"];
                        
                        
                          [[NSUserDefaults standardUserDefaults]setObject:_passwordFld.text forKey:@"USER_PASS_MAIN"];
                        
                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[JSON valueForKeyPath:@"user_details"][0]];
                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"USER_DATAS"];
                        
                         DashboardViewController *signObj =[[DashboardViewController alloc]init];
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


-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
    
     [self.navigationController popViewControllerAnimated:YES];
    
}
@end
