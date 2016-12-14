//
//  ViewController.m
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden =TRUE;
    [super viewDidLoad];
    
    
    
    
    
    
    
    if([[[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] isEqualToString:@""] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"] == [NSNull null] || [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"].length == 0)
    {
        
    }
    else
    {
       
            
        
            DashboardViewController *dashObj =[[DashboardViewController alloc]init];
            [self.navigationController pushViewController:dashObj animated:NO];
             
            
        
        
        
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
    
    LoginViewController *dashObj =[[LoginViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
    
    
}


- (IBAction)forgotPasswordBtn:(id)sender
{
    
   
    
}

- (IBAction)facebookBtn:(id)sender {
}

- (IBAction)clickSignUp:(id)sender {
    
    CountryViewController *signObj =[[CountryViewController alloc]init];
    [self.navigationController pushViewController:signObj animated:YES];
}
@end
