//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "DetailViewController.h"

#import "AFNetworking.h"

#define CASE(str)                       if ([__s__ isEqualToString:(str)])
#define SWITCH(s)                       for (NSString *__s__ = (s); ; )
#define DEFAULT

@interface DetailViewController ()
{
   
    NSMutableArray *dataArray;
    
    NSMutableArray *dataArrayNew;
    
    NSMutableArray *checkMarkArrayNew;
    int totalChecked;
    
    int currentIndex;
}
@end

@implementation DetailViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSString *familyName in [UIFont familyNames])
    {
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName])
        {
            NSLog(@"--Font name: %@", fontName);
        }
    }
    
    self.tblView.tableFooterView =[[UIView alloc]initWithFrame:CGRectZero];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
   
    self.topView.layer.masksToBounds = NO;
    self.topView.layer.shadowOffset = CGSizeMake(0, 3);
    self.topView.layer.shadowRadius = 5;
    self.topView.layer.shadowOpacity = 0.5;
    
    
    _view2.layer.cornerRadius = 3.0;
    _view2.layer.borderWidth = 1.0;
    _view2.layer.borderColor = [UIColor clearColor].CGColor;
    _view2.layer.masksToBounds = YES;

    [self getDatas];
    
}
-(void)getDatas
{
    [ProgressHUD show:nil];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",self.getshopId] forKey:@"shop_id"];
    NSLog(@"Params:%@",parameters);
    
    NSString *urlString=[NSString stringWithFormat:@"%@shop_details",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         NSError *error = nil;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         NSLog(@"JSON:%@",JSON);
         if ([[JSON valueForKey:@"status"] intValue]!=200)
         {
             [ProgressHUD showError:[JSON valueForKey:@"message"]];
         }
         else
         {
             NSArray *getDatas =[JSON valueForKey:@"allshops"];
             getDetails =[getDatas objectAtIndex:0];
             NSString *mainUrl=[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"logoimage"]];
             [self.bannerImage sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                                 placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
             self.bannerLabel.text =[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"name"]];
             [ProgressHUD dismiss];
             [_tblView reloadData];
             [self getComments];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [ProgressHUD showError:error.localizedDescription];
     }];
}

-(void)getComments
{
    getComments =[[NSMutableArray alloc] init];
    [ProgressHUD show:nil];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",self.getshopId] forKey:@"prodid"];
    NSLog(@"Params:%@",parameters);
    
    NSString *urlString=[NSString stringWithFormat:@"%@get_comments",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
    {
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        if ([[JSON valueForKey:@"status"] intValue]!=200)
        {
           // [ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            getComments =[JSON valueForKey:@"detail"];
            [ProgressHUD dismiss];
            [_tblView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);
        [ProgressHUD showError:error.localizedDescription];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0)
    {
        if (getDetails.count !=0)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return getComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *CellIdentifier = @"Cell";
        DetailFirstSectionTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil)
        {
            NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DetailFirstSectionTableViewCell" owner:nil options:nil];
            for (UIView *view in views)
            {
                if([view isKindOfClass:[UITableViewCell class]])
                {
                    cell1 = (DetailFirstSectionTableViewCell*)view;
                }
            }
        }
        
        CLLocation *location = [locationManager location];
        float currentlongitude=location.coordinate.longitude;
        float currentlatitude=location.coordinate.latitude;
        float newlongitude=[[NSString stringWithFormat:@"%@",[getDetails valueForKeyPath:@"longitude"]] floatValue];
        float newlatitude=[[NSString stringWithFormat:@"%@",[getDetails valueForKeyPath:@"latitude"]] floatValue];
        CLLocation *locA = [[CLLocation alloc] initWithLatitude:currentlatitude longitude:currentlongitude];
        CLLocation *locB = [[CLLocation alloc] initWithLatitude:newlatitude longitude:newlongitude];
        CLLocationDistance distance = [locA distanceFromLocation:locB];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = newlatitude;
        coordinate.longitude = newlongitude;
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:coordinate];
        [annotation setTitle:[getDetails valueForKey:@"name"]];
        [cell1.mapObj addAnnotation:annotation];
        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
        MKCoordinateRegion region = {coordinate, span};
        [cell1.mapObj setRegion:region];
        
        NSString *nameStr =[NSString stringWithFormat:@"%@  ",[getDetails valueForKey:@"name"]];
        UIFont *arialFont = [UIFont fontWithName:@"Swiss721BT-RomanCondensed" size:18.0];
        NSDictionary *arialDict = [NSDictionary dictionaryWithObject: arialFont forKey:NSFontAttributeName];
        NSMutableAttributedString *aAttrString = [[NSMutableAttributedString alloc] initWithString:nameStr attributes: arialDict];
        
        NSString *cityStr =[NSString stringWithFormat:@"%@ | %@",[getDetails valueForKey:@"state"], [NSString stringWithFormat:@"%.1f KM",(distance/1000)]];
        UIFont *VerdanaFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
        NSDictionary *verdanaDict = [NSDictionary dictionaryWithObject:VerdanaFont forKey:NSFontAttributeName];
        NSRange range = [cityStr rangeOfString:cityStr];
        NSMutableAttributedString *vAttrString = [[NSMutableAttributedString alloc]initWithString:cityStr  attributes:verdanaDict];
        [vAttrString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [aAttrString appendAttributedString:vAttrString];
        cell1.nameLabel.attributedText = aAttrString;
        
     
        cell1.aboutText.text =[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"about"]];
        cell1.addressLabel.text =[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"address"]];
        cell1.numberLabel.text =[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"contact_no"]];
        cell1.timingsLabel.text =[NSString stringWithFormat:@"Opening Hours : %@ - %@",[getDetails valueForKey:@"opening_time"],[getDetails valueForKey:@"closing_time"]];
        
        cell1.starRating.maximumValue = 5;
        cell1.starRating.minimumValue = 0;
        cell1.starRating.enabled = FALSE;
        cell1.starRating.value = [[NSString stringWithFormat:@"%@",[getDetails valueForKey:@"ave_rating"]] floatValue];
        cell1.starRating.tintColor = [UIColor colorWithRed:70.0/255 green:165.0/255 blue:244.0/255 alpha:1.0];
        
        returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
        [cell1.addCommentFld addCancelDoneOnKeyboardWithTarget:self cancelAction:@selector(cancelComment) doneAction:@selector(addComment) titleText:@"Add Comment"];
        cell1.addCommentFld.tag = 100;
        [cell1.addCommentFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        cell1.addCommentFld.delegate = self;
        
        cell1.selectionStyle = UITableViewCellAccessoryNone;
        return cell1;

    }
    else
    {
        NSDictionary *currDict =[getComments objectAtIndex:indexPath.row];
        
        static NSString *CellIdentifier = @"Cell";
        CommentTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil)
        {
            NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:nil options:nil];
            for (UIView *view in views)
            {
                if([view isKindOfClass:[UITableViewCell class]])
                {
                    cell1 = (CommentTableViewCell*)view;
                }
            }
        }
        cell1.userName.text = [NSString stringWithFormat:@"%@",[currDict valueForKey:@"comment_by"]];
        cell1.userMsg.text = [NSString stringWithFormat:@"%@",[currDict valueForKey:@"comment_details"]];
        NSString *mainUrl=[NSString stringWithFormat:@"%@",[currDict valueForKey:@"comment_orig_image"]];
        [cell1.userImage sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                            placeholderImage:[UIImage imageNamed:@"ICON-1r.png"]];
        cell1.userImage.layer.cornerRadius = cell1.userImage.frame.size.height/2;
        cell1.userImage.clipsToBounds = true;
        cell1.selectionStyle = UITableViewCellAccessoryNone;
        return cell1;

    }
}
- (void)textFieldDidChange :(UITextField *)theTextField
{
    commentStr =theTextField.text;
}
-(void)addComment
{
    NSLog(@"Add Comment %@",commentStr);
    if (commentStr.length ==0)
    {
        [ProgressHUD showError:@"Please add comment"];
    }
    else
    {
        [ProgressHUD show:nil];
        
        NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_DATAS"];
        NSDictionary *getUserData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
        
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setObject:[NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@",[getUserData valueForKey:@"name"]]] forKey:@"name"];
        [parameters setObject:[NSString stringWithFormat:@"%@",commentStr] forKey:@"comments"];
        [parameters setObject:[NSString stringWithFormat:@"%@",self.getshopId] forKey:@"prodid"];
        NSLog(@"Params:%@",parameters);
        
        NSString *urlString=[NSString stringWithFormat:@"%@comments",ApiBaseURL];
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
         {
             NSError *error = nil;
             NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
             
             NSLog(@"JSON:%@",JSON);
             if ([[JSON valueForKey:@"status"] intValue]!=200)
             {
                 [ProgressHUD showError:[JSON valueForKey:@"message"]];
             }
             else
             {
                 [ProgressHUD showSuccess:@"Comment Submitted"];
                 [self getComments];
             }
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
             NSLog(@"Error: %@", error);
             [ProgressHUD showError:error.localizedDescription];
         }];
    }
    [self.view endEditing:YES];
}
-(void)cancelComment
{
    [self.view endEditing:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 630;
    }
    else
    {
        return 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


- (IBAction)backBtn:(id)sender
{

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)twitterShare:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"%@ ",[getDetails valueForKey:@"name"]]];
        [tweetSheet addImage:self.bannerImage.image];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)fbShare:(id)sender
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[NSString stringWithFormat:@"%@ ",[getDetails valueForKey:@"name"]]];
        [controller addImage:self.bannerImage.image];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}
@end
