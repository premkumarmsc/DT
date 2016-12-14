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


@interface SettingsViewController : UIViewController<ADPageControlDelegate>
{
    ADPageControl *pageControlObj;
}

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *lblTopLabel;


@property (weak, nonatomic) IBOutlet UIView *viewPageControl;

@property (weak, nonatomic) IBOutlet UITableView *tblView;
- (IBAction)clickGPS:(id)sender;
- (IBAction)clickLogout:(id)sender;

@end
