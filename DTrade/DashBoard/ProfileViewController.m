//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ProfileViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface ProfileViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
    
    NSString *base64String;
}
@end

@implementation ProfileViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    _view1.layer.cornerRadius = 10.0;
    _view1.layer.borderWidth = 1.0;
    _view1.layer.borderColor = [UIColor clearColor].CGColor;
    _view1.layer.masksToBounds = YES;
    
    _view2.layer.cornerRadius = 3.0;
    _view2.layer.borderWidth = 1.0;
    _view2.layer.borderColor = [UIColor clearColor].CGColor;
    _view2.layer.masksToBounds = YES;

    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATAS"];
    
    NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    NSLog(@"Get Data:%@",getUserData);
    
    
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2;
    _imgUser.clipsToBounds = true;
    
    

    
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[getUserData valueForKey:@"thumb_image"]];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    
    
    
    _lblName.text = [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"name"]];
    
    _lblSubName.text =  [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"emailid"]];;
    
    
       _lblLocation.text = [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"state"]];
    
    _lblPhone.text = [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"phone_no"]];
       
}



- (IBAction)backBtn:(id)sender
{
    

    [self.navigationController popViewControllerAnimated:YES];
    
}




- (IBAction)clickeditProfile:(id)sender {
        
    EditViewController *dashObj =[[EditViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
}
@end
