//
//  MyCell.h
//  TestCollectionViewWithXIB
//
//  Created by Quy Sang Le on 2/3/13.
//  Copyright (c) 2013 Quy Sang Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavCellSmall : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UIImageView *image_view;

@property (weak, nonatomic) IBOutlet UIView *favView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *iconFav;

@end

