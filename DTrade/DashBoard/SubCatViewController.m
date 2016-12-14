//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "SubCatViewController.h"
#import "AFNetworking.h"


@interface SubCatViewController ()
{
    
    NSMutableArray *dataArray;
    NSMutableArray *viewsArray;
    NSMutableArray *catArray;
}
@end

@implementation SubCatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataArray = [[NSMutableArray alloc]init];
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"SLIDER_IMAGES"];
    NSArray *getImageData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    [dataArray addObjectsFromArray:getImageData];
    NSString *catName = [[NSUserDefaults standardUserDefaults]stringForKey:@"CAT_NAME"];
    _topLabel.text = catName;
    
   
    NSString *catId = [[NSUserDefaults standardUserDefaults]stringForKey:@"CAT_ID"];
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",catId] forKey:@"catid"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@subcategory_ads",ApiBaseURLNew];
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
             dataArray = [[NSMutableArray alloc]init];
             [dataArray addObjectsFromArray:[JSON valueForKey:@"ad_details"]];
             NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
             [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SLIDER_IMAGES"];
         }
         JScrollView_PageControl_AutoScroll *view;
         view=[[JScrollView_PageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, _viewBanner.frame.size.width, _viewBanner.frame.size.height)];
         viewsArray=[[NSMutableArray alloc]init];
         for (int i=0; i<[dataArray count]; i++)
         {
             UIImageView *imageView= [[UIImageView alloc]init];
             imageView.contentMode=UIViewContentModeScaleToFill;
             NSDictionary *dict = dataArray[i];
             NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"ad_orig_image"]];
             [imageView sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                          placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
             [viewsArray addObject:imageView];
         }
         view.autoScrollDelayTime=5.0;
         view.delegate=self;
         [view setViewsArray:viewsArray];
         [_viewBanner addSubview:view];
         [view shouldAutoShow:YES];
         [ProgressHUD dismiss];
     }
     failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Error: %@", error);
         [ProgressHUD showError:error.localizedDescription];
     }];
    [self gedatas];
}

-(void)gedatas
{
    [ProgressHUD show:nil];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    NSString *catId = [[NSUserDefaults standardUserDefaults]stringForKey:@"CAT_ID"];
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",catId] forKey:@"catid"];
    [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"user_id"];
    

    NSLog(@"Params:%@",parameters);
    
    NSString *urlString=[NSString stringWithFormat:@"%@get_subcategory",ApiBaseURL];
    
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
            
            
            [ProgressHUD showError:[JSON valueForKey:@"message"]];
        }
        else
        {
            catArray = [[NSMutableArray alloc]init];
            
            [catArray addObjectsFromArray:[JSON valueForKey:@"allsubcategory"]];
            
            [ProgressHUD dismiss];
        }
        
        
        [_tblView reloadData];
        
       // [ProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}


- (IBAction)backBtn:(id)sender
{
    

    
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
    
    
    
    AssignmentTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"AssignmentTableViewCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (AssignmentTableViewCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    
 
    NSDictionary *dict = catArray[indexPath.section];
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subcategory_name"]];
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"descriptions"]];
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"subcategory_main_image"]];
    
    [cell1.imgAttach sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                       placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    
    
    

    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
 
    
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = catArray[indexPath.section];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subcategory_id"]] forKey:@"SUB_CAT_ID"];
    
     [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"subcategory_name"]] forKey:@"SUB_CAT_NAME"];
    
    ListViewController *dashObj =[[ListViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
}


- (IBAction)clickSearch:(id)sender {
    
    SearchListViewController *dashObj =[[SearchListViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
}


@end
