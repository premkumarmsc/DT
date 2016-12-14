//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "DashboardViewController.h"
#import "AFNetworking.h"


@interface DashboardViewController ()
{
    
    NSMutableArray *dataArray;
    NSMutableArray *catArray;
    NSMutableArray *viewsArray;
}
@end

@implementation DashboardViewController


NSMutableArray *checkMarkArrayNew;
int totalChecked;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@category_ads",ApiBaseURLNew];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
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
    
    /*
    JScrollView_PageControl_AutoScroll *view;
           view=[[JScrollView_PageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, _viewBanner.frame.size.width, _viewBanner.frame.size.height)];
    viewsArray=[[NSMutableArray alloc]init];
    for (int i=0; i<5; i++)
    {
        UIImageView *imageView= [[UIImageView alloc]init];
        imageView.contentMode=UIViewContentModeScaleToFill;
        imageView.image = [UIImage imageNamed:@"banner.png"];
        [viewsArray addObject:imageView];
    }
    view.autoScrollDelayTime=5.0;
    view.delegate=self;
    [view setViewsArray:viewsArray];
    [_viewBanner addSubview:view];
    [view shouldAutoShow:YES];
     */
    
    [self assignView:_shareSubView];
    
    [self gedatas];
    
}

-(void)gedatas
{
    [ProgressHUD show:nil];
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@allcategories",ApiBaseURL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
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
            
            [catArray addObjectsFromArray:[JSON valueForKey:@"allcategory"]];
        }
        
        
        [_tblView reloadData];
        
        [ProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
}

-(void)assignView:(UIView *)view
{
    view.layer.cornerRadius = 3.0;
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.masksToBounds = YES;
}




- (IBAction)backBtn:(id)sender
{
    

    CGRect basketTopFrame = _backView.frame;
    // basketTopFrame.origin.x = -basketTopFrame.size.width;
    
    
    /*
    if(IS_IPHONE_6){
        basketTopFrame.origin.x = 300;
    }
    if(IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)
    {
        basketTopFrame.origin.x = 250;
    }
    if(IS_IPHONE_6P){
        basketTopFrame.origin.x = 330;
    }
    */
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         _backView.frame = basketTopFrame;
                         // basketBottom.frame = basketBottomFrame;
                     }
                     completion:^(BOOL finished)
     {
         //NSLog(@"Done 1233!");
         
         
         
         
     }];
    
    
    
    
    
    
    SideView *sideView=[[SideView alloc]init];
    sideView.delegate= self;
    sideView.frame = self.view.bounds;
    [self.view addSubview:sideView];
    
}

- (void)didTapSomeButton:(NSString *)getController
{
    NSLog(@"Tabbed:%@",getController);
    
    
    if ([getController isEqualToString:@"CONTACT US"]) {
        
        
        
        
        ContactViewController *dashObj =[[ContactViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    if ([getController isEqualToString:@"ABOUT US"]) {
        
        
        
        
        AboutViewController *dashObj =[[AboutViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
        
        
        
        
        
    }
    
    if ([getController isEqualToString:@"EXIBITION"]) {
        
                ExibitionViewController *dashObj =[[ExibitionViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    if ([getController isEqualToString:@"SETTINGS"]) {
        
        SettingsViewController *dashObj =[[SettingsViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    if ([getController isEqualToString:@"PROFILE"]) {
        
        ProfileViewController *dashObj =[[ProfileViewController alloc]init];
        [self.navigationController pushViewController:dashObj animated:YES];
        
    }
    
    if ([getController isEqualToString:@"SHARE"]) {
        
        _shareView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        
        
        _shareView.hidden = NO;
        
        [self.view addSubview:_shareView];

        
    }

   
    
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
    
    
       
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
    
 
    NSDictionary *dict = catArray[indexPath.section];
    
    
    
    
    
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@ (%@)",[dict valueForKeyPath:@"category_name"],[dict valueForKeyPath:@"number_of_products"]];
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"descriptions"]];
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"category_main_image"]];
    
    [cell1.imgAttach sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                    placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    

    
    
    return cell1;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 83;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSDictionary *dict = catArray[indexPath.section];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"category_id"]] forKey:@"CAT_ID"];
    
     [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"category_name"]] forKey:@"CAT_NAME"];
    
    SubCatViewController *dashObj =[[SubCatViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
}




- (IBAction)clickSearch:(id)sender {
    
    SearchListViewController *dashObj =[[SearchListViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
    //[self presentModalViewController:dashObj animated:YES];

}
- (IBAction)clickShareSubmit:(id)sender {
    
    
    [ProgressHUD show:nil];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:_txtShare.text forKey:@"user_infos"];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"USER_ID_MAIN"];
    [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"user_id"];
    

    if(_slider.selectedSegmentIndex == 0)
    {
        [parameters setObject:@"mail" forKey:@"user_choice"];
    }
    else
    {
        [parameters setObject:@"mobile" forKey:@"user_choice"];
    }
    
    //[parameters setObject:_passwordFld.text forKey:@"userpass"];
    
    
    NSLog(@"Params:%@",parameters);
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@classy_user_sharings",ApiBaseURL];
    
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
        
        
        
     
            
            [ProgressHUD showSuccess:[JSON valueForKey:@"message"]];
            
            
            _shareView.hidden = YES;
        
        
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    
    

    
    
    
}
- (IBAction)changeSlider:(id)sender {
    
    
    
    if(_slider.selectedSegmentIndex == 0)
    {
        _txtShare.placeholder = @"Email Address";
    }
    else
    {
        _txtShare.placeholder = @"Mobile Number";
    }
    
}
- (IBAction)closeShare:(id)sender {
    
    _shareView.hidden = YES;
   
}
@end
