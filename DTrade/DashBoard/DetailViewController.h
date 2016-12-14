//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MapKit/MapKit.h>
#import "MBProgressHUD.h"
#import "ADPageControl.h"
#import "DetailFirstSectionTableViewCell.h"
#import "CommentTableViewCell.h"

#import "IQKeyBoardManager.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "IQUIView+IQKeyboardToolbar.h"

@interface DetailViewController : UIViewController<ADPageControlDelegate,CLLocationManagerDelegate,UITextFieldDelegate>
{
    ADPageControl *pageControlObj;
    CLLocationManager *locationManager;
    NSArray *getDetails;
    NSMutableArray *getComments;
    
    NSString *commentStr;
    IQKeyboardReturnKeyHandler *returnKeyHandler;

}
@property (nonatomic,retain) NSString *getshopId;
- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet UILabel *bannerLabel;
- (IBAction)twitterShare:(id)sender;
- (IBAction)fbShare:(id)sender;



@end
