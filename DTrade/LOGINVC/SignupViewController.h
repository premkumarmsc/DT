//
//  ViewController.h
//  Hello Cabs
//
//  Created by SYZYGY on 25/11/16.
//  Copyright © 2016 Syzygy Enterprise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import "ForgotPasswordViewController.h"
//#import "RegisterViewController.h"

@interface SignupViewController : UIViewController

- (IBAction)loginBtn:(id)sender;
- (IBAction)forgotPasswordBtn:(id)sender;
- (IBAction)facebookBtn:(id)sender;
- (IBAction)registerBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *numberFld;
@property (weak, nonatomic) IBOutlet UITextField *passwordFld;
@property (weak, nonatomic) IBOutlet UIView *viewNumber;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
- (IBAction)clickSignUp:(id)sender;
- (IBAction)clickBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
- (IBAction)clickDOB:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
- (IBAction)clickMale:(id)sender;
- (IBAction)clickFemale:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblMale;
@property (weak, nonatomic) IBOutlet UILabel *lblFemale;
@property (weak, nonatomic) IBOutlet UIView *viewFb;

@end

