//
//  SideView.m
//  MyPractice
//
//  Created by eph132 on 10/06/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

#import "SideView.h"
#import "CategoryMenu.h"
#import "DetailCell.h"
#import "SectionInfo.h"



#define DEFAULT_ROW_HEIGHT 157
#define HEADER_HEIGHT 50


@interface SideView ()
-(void)openDrawer;
-(void)closeDrqwer;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *sectionInfoArray;
@property (nonatomic, strong) NSArray *categoryList;
- (void) setCategoryArray;
@end

@implementation SideView
{
    
    NSArray *topItems;
    NSMutableArray *subItems; // array of arrays
    
    int currentExpandedIndex;
    UITableView *_tableView;
}


@synthesize categoryList = _categoryList;
@synthesize openSectionIndex;
@synthesize sectionInfoArray;


SideView *side;

NSArray *titleArray;
NSArray *imageArray;
NSArray *vcArray;


- (id)init{
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                          owner:self
                                        options:nil]
            objectAtIndex:0];
    
    
    [side sizeToFit];
    
   
       
    
   
    
    
    CGRect basketTopFrame = side.frame;
    
    basketTopFrame.origin.x = -320;
    
   // NSLog(@"Width:%f",basketTopFrame.size.width);
   //  NSLog(@"Width:%f",basketTopFrame.size.height);
    
    
    side.frame = basketTopFrame;
   
    
    _closeView.hidden=YES;
    
    
    _gesView.hidden = NO;
    
        [self openDrawer];
    
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    
    
    
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_gesView addGestureRecognizer:gestureRecognizer];

    
    
    [_menuTableView reloadData];
    
    
    return side;
    
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Swipe received.");
    _gesView.hidden = YES;
    [self closeDrawer:nil];
}


- (void)configureWith:(id<customProtocol>)delegate{
    //Configure the delegate it will manage the events
    //from subviews like buttons and other controls
    self.delegate = delegate;
    //.. to configure any subView
}


- (void) awakeFromNib
{
    
   
       // _imgUser.layer.frame = CGRectMake(15, 50, 70, 70);
    _imgUser.layer.cornerRadius = _imgUser.frame.size.height/2;
    _imgUser.clipsToBounds = true;

    
   
    
   // [self setCategoryArray];
    //self.menuTableView.sectionHeaderHeight = 45;
   // self.menuTableView.sectionFooterHeight = 0;
   // self.openSectionIndex = NSNotFound;
    
    vcArray=[NSArray arrayWithObjects:@"HOME",@"ABOUT US",@"PROFILE",@"EXIBITION",@"SHARE",@"SETTINGS",@"CONTACT US", nil];
    
    
    
    titleArray=[NSArray arrayWithObjects:@"HOME",@"ABOUT US",@"PROFILE",@"EXHIBITION",@"SHARE",@"SETTINGS",@"CONTACT US", nil];
        
        
    
    
    
    
    imageArray=[NSArray arrayWithObjects:@"icon-1.png", @"icon-2.png", @"icon-3.png", @"icon-4.png", @"icon-5.png", @"icon-6.png", @"icon-7.png", nil];
    
    
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATAS"];
    
    NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    NSLog(@"Get Data:%@",getUserData);
    
    
    
    
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[getUserData valueForKey:@"thumb_image"]];
    
    [_imgUser sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                       placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    
    
    
    _lblName.text = [NSString stringWithFormat:@"Hi, %@",[getUserData valueForKey:@"name"]];
    
    _lblSubName.text =  [NSString stringWithFormat:@"%@",[getUserData valueForKey:@"emailid"]];;
    
    
   
    _lblPoints.text =  [NSString stringWithFormat:@"You have %d points",[[getUserData valueForKey:@"sharing_points"] intValue]];;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"E, MMM d"];
    NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
    
    _lblLast.text =  [NSString stringWithFormat:@"Last synced: %@",dayName];;
    

    
    
    [super awakeFromNib];
    
}



- (id)initWithTitle:(NSString *)aTitle options:(NSArray *)aOptions {
    CGRect rect = [[UIScreen mainScreen] applicationFrame]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        rect.size = CGSizeMake(rect.size.height, rect.size.width);
    }
    if (self = [super initWithFrame:rect])
    {
       
       
        
    }
    return self;
}





/*
- (id)initWithTitle:(NSString *)aTitle
            options:(NSArray *)aOptions
            handler:(void (^)(NSInteger anIndex))aHandlerBlock {
    
    
    
    
   
    
    if(self = [self initWithTitle:aTitle options:aOptions])
        self.handlerBlock = aHandlerBlock;
    
    return self;
}
 */

- (void)setUpTableView
{
}


#pragma mark - Instance Methods
- (void)showInView:(UIView *)aView animated:(BOOL)animated
{
    
    
    
 
    
  
    
    
    
    side = [[[NSBundle mainBundle] loadNibNamed:@"SideView"
                                         owner:self
                                       options:nil]
           objectAtIndex:0];
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    side.frame = basketTopFrame;
    
    //side.delegate = self;
    
    [aView addSubview: side];
    //side.hidden=YES;
    
    
    
    if (animated) {
        
         _gesView.hidden = NO;
        [self openDrawer];
    }
    
    [_menuTableView reloadData];
    
    
}

-(void)openDrawer
{
    side.hidden=NO;
    _closeView.hidden=YES;
    
    
    
    
    
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = 0;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done! AAA");
         
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _closeView.hidden=NO;
         });
         
         
     }];
    
    
    
    

}



- (IBAction)closeDrawer:(id)sender {
    
     _gesView.hidden = YES;
    
    [_delegate didTapSomeButton:@"Close"];
    
    side.hidden=NO;
    _closeView.hidden=YES;
    CGRect basketTopFrame = side.frame;
    //basketTopFrame.origin.x = basketTopFrame.size.width;
    basketTopFrame.origin.x = -320;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         side.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         NSLog(@"Done!");
         
         
         
         
         [self removeFromSuperview];
         
     }];

    
     
    
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (DetailCell*)view;
            }
        }
    }
    
    cell1.emptyDate.text=titleArray[indexPath.row];
    cell1.img.image= [UIImage imageNamed:imageArray[indexPath.row]];
   
    return cell1;

    
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    //SectionInfo *array = [self.sectionInfoArray objectAtIndex:indexPath.section];
    //return [[array objectInRowHeightsAtIndex:indexPath.row] floatValue];
    
    
    return 47;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSLog(@"Index:%ld",(long)indexPath.row);
        
        [_delegate didTapSomeButton:vcArray[indexPath.row]];
   
    _gesView.hidden = YES;
    [self closeDrawer:nil];
    
    
   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)clickSettings:(id)sender {
    
     [_delegate didTapSomeButton:@"UserSettings"];
    
    _gesView.hidden = YES;
    
    [self closeDrawer:nil];
    
}
- (IBAction)clickProfile:(id)sender {
    
    _gesView.hidden = YES;
    [_delegate didTapSomeButton:@"UserProfile"];
    [self closeDrawer:nil];
}
@end
