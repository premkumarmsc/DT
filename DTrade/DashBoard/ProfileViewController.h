//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "ADPageControl.h"


@interface ProfileViewController : UIViewController<ADPageControlDelegate>
{
    ADPageControl *pageControlObj;
}

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *lblTopLabel;


@property (weak, nonatomic) IBOutlet UIView *viewPageControl;

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)clickeditProfile:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblSubName;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@end
