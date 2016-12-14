//
//  CommentTableViewCell.h
//  DTrade
//
//  Created by SYZYGY on 09/12/16.
//  Copyright © 2016 Prem Kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userMsg;

@end
