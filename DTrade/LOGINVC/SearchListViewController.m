//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "SearchListViewController.h"
#import "AFNetworking.h"


@interface SearchListViewController ()
{
    
    NSMutableArray *dataArray;
    NSMutableArray *viewsArray;
     NSMutableArray *catArray;
}
@end

@implementation SearchListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_txtSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
   
    
    
}

-(void)gedatas : (NSString *)searchString
{
    //[ProgressHUD show:nil];
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",searchString] forKey:@"svalue"];
   // [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"scatid"];
    
    
    NSLog(@"Params:%@",parameters);
    
    NSString *urlString=[NSString stringWithFormat:@"%@allshopssearch",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"Success: %@", responseObject);
        
        NSError *error = nil;
        NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"JSON:%@",JSON);
        
        
        
        if ([[JSON valueForKey:@"status"] intValue]!=200)
        {
            
            
            //[ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            catArray = [[NSMutableArray alloc]init];
            
            [catArray addObjectsFromArray:[JSON valueForKey:@"allshops"]];
            
           // [ProgressHUD dismiss];
        }
        
        
        [_tblView reloadData];
        
        // [ProgressHUD dismiss];
        
        
       
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
      //  [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    
    [self gedatas:theTextField.text];
}

- (IBAction)backBtn:(id)sender
{
    

    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [catArray count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    return view;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 10;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    
    DetailTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (DetailTableViewCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
    
    NSDictionary *dict = catArray[indexPath.section];
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"name"]];
    
    NSString *mainUrl = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"logoimage"]];
    
    
    
    
    
    CLLocation *location = [locationManager location];
    // Configure the new event with information from the location
    
    float currentlongitude=location.coordinate.longitude;
    float currentlatitude=location.coordinate.latitude;
    
    NSLog(@"dLongitude : %f", currentlongitude);
    NSLog(@"dLatitude : %f", currentlatitude);
    
    
    float newlongitude=[[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"longitude"]] floatValue];
    float newlatitude=[[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"latitude"]] floatValue];
    
    
    NSLog(@"dLongitude : %f", newlongitude);
    NSLog(@"dLatitude : %f", newlatitude);
    
    
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:currentlatitude longitude:currentlatitude];
    
    CLLocation *locB = [[CLLocation alloc] initWithLatitude:newlatitude longitude:newlongitude];
    
    CLLocationDistance distance = [locA distanceFromLocation:locB];
    
   // NSLog(@"The distance is %@", convertDistanceToString(distance));
    
    
    cell1.lblSubtitle.text=[NSString stringWithFormat:@"%@ | %@",[dict valueForKey:@"state"], [NSString stringWithFormat:@"%.1f KM",(distance/1000)]];
    
    
    cell1.imgAttach.layer.cornerRadius = cell1.imgAttach.frame.size.height/2;
    cell1.imgAttach.clipsToBounds = true;
    
    cell1.starRating.maximumValue = 5;
    cell1.starRating.minimumValue = 0;
    cell1.starRating.value = 4;
    cell1.starRating.tintColor = [UIColor colorWithRed:70.0/255 green:165.0/255 blue:244.0/255 alpha:1.0];
    
    
    
    [cell1.imgAttach sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                       placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    
    
    
    
    
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
    
    
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *dict = catArray[indexPath.section];
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SHOP_DETAILS"];
    
    //[self dismissViewControllerAnimated:NO completion:nil];
    DetailViewController *dashObj =[[DetailViewController alloc]init];
    dashObj.getshopId =[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
    [self.navigationController pushViewController:dashObj animated:YES];
}





@end
