//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "SettingsViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface SettingsViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation SettingsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
       
}



- (IBAction)backBtn:(id)sender
{
    

    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}




- (IBAction)clickGPS:(id)sender {
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)clickLogout:(id)sender {
    
    
    
    [UIAlertView showWithTitle:@"Logout"
                       message:@"Are you sure you want to Logout?"
             cancelButtonTitle:@"No"
             otherButtonTitles:@[@"Yes"]
                      tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                          if (buttonIndex == [alertView cancelButtonIndex]) {
                              NSLog(@"Cancelled");
                          } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
                              NSLog(@"Have a cold beer");
                              
                              
                              
                              [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"USER_ID_MAIN"];
                              
                              
                              
                              
                              
                              ViewController *dashObj =[[ViewController alloc]init];
                              [self.navigationController pushViewController:dashObj animated:YES];
                          }
                      }];

    
}
@end
