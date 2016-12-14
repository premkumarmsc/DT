//
//  ReviewViewController.h
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "JScrollView+PageControl+AutoScroll.h"


@interface DashboardViewController : UIViewController<JScrollViewViewDelegate,UIScrollViewDelegate>

- (IBAction)backBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollingobj;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewFav;
@property (weak, nonatomic) IBOutlet UILabel *lblClasses;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UILabel *lblmonth;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UIView *viewBanner;
- (IBAction)clickSearch:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UIView *shareSubView;
- (IBAction)clickShareSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtShare;
- (IBAction)changeSlider:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *slider;
- (IBAction)closeShare:(id)sender;

@end
