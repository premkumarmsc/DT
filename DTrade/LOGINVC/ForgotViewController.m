//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "ForgotViewController.h"

@interface ForgotViewController ()

@end

@implementation ForgotViewController

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
            
                [ProgressHUD show:nil];
                
                NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
                [parameters setObject:_numberFld.text forKey:@"your_email"];
                //[parameters setObject:_passwordFld.text forKey:@"userpass"];
                
                
                NSLog(@"Params:%@",parameters);
                
                
                NSString *urlString=[NSString stringWithFormat:@"%@forgot_pass",ApiBaseURL];
                
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
                        
                        
                        [self clickBack:nil];
                    }
                    
                    

                    
                    
                    
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"Error: %@", error);
                    
                    
                    [ProgressHUD showError:error.localizedDescription];
                    
                    
                }];
                
                
                
                
            
            
        }
        
        
        
    }

    
    
}


- (IBAction)forgotPasswordBtn:(id)sender
{
    /*
    ForgotPasswordViewController *signObj =[[ForgotPasswordViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
     */
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
