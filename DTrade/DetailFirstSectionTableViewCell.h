//
//  DetailFirstSectionTableViewCell.h
//  DTrade
//
//  Created by SYZYGY on 09/12/16.
//  Copyright © 2016 Prem Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingView.h"
#import "HCSStarRatingView.h"

@interface DetailFirstSectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *timingsLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapObj;
@property (weak, nonatomic) IBOutlet UITextView *aboutText;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRating;
@property (weak, nonatomic) IBOutlet UITextField *addCommentFld;
@property (weak, nonatomic) IBOutlet UILabel *lblCommendsLbl;

@end
