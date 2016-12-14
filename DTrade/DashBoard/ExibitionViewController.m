//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ExibitionViewController.h"
#import "AFNetworking.h"


@interface ExibitionViewController ()
{
    
    NSMutableArray *dataArray;
    NSMutableArray *viewsArray;
    NSMutableArray *catArray;

}
@end

@implementation ExibitionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    dataArray = [[NSMutableArray alloc]init];
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"SLIDER_IMAGES"];
    
    NSArray *getImageData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    [dataArray addObjectsFromArray:getImageData];
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@allsliders",ApiBaseURL];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"parse-application-id-removed" forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:@"parse-rest-api-key-removed" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
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
             [dataArray addObjectsFromArray:[JSON valueForKey:@"detail"]];
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
             NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"slider_orig_image"]];
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
    
    NSString *urlString=[NSString stringWithFormat:@"%@allexhibitions",ApiBaseURL];
    
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
            
            [catArray addObjectsFromArray:[JSON valueForKey:@"allexhibitions"]];
            
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
    
    
    
    ExcibitionTableViewCell * cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil)
    {
        
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"ExcibitionTableViewCell" owner:nil options:nil];
        
        for (UIView *view in views)
        {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell1 = (ExcibitionTableViewCell*)view;
                //cell.img=@"date.png";
                
            }
        }
    }
    
    cell1.selectionStyle = UITableViewCellAccessoryNone;
 
    NSDictionary *dict = catArray[indexPath.section];
    
    cell1.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"exhibition_name"]];
    
    cell1.lblSubtitle.text = [NSString stringWithFormat:@"Venue : %@",[dict valueForKeyPath:@"exhibition_venue"]];
    
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"exhibition_thumb_image"]];
    
    [cell1.imgAttach sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                       placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    cell1.imgAttach.layer.cornerRadius = cell1.imgAttach.frame.size.height/2;
    cell1.imgAttach.clipsToBounds = true;
    
    
    [cell1.btnQr setTag:indexPath.row];
    [cell1.btnQr addTarget:self action:@selector(LevelClicked:)
           forControlEvents:UIControlEventTouchDown];
    
    return cell1;
    
    
}

-(void)LevelClicked:(UIButton*)button
{
    NSDictionary *dict = catArray[(long int)[button tag]];
    

    NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"qrcode_image"]];
    
    

    // Here we need to pass a full frame
    CustomIOSAlertView *alertView = [[CustomIOSAlertView alloc] init];
    
    alertView.backgroundColor = [UIColor whiteColor];
    // Add some custom content to the alert view
   // [alertView setContainerView:[self createDemoView:mainUrl]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Close", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOSAlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
    
    
    
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOSAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    [alertView close];
}
- (UIView *)createDemoView :(NSString *)urlText
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
   // [imageView setImage:[UIImage imageNamed:@"demo"]];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *encodedUrl = [urlText stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:encodedUrl]
                       placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    [demoView addSubview:imageView];
    
    demoView.backgroundColor = [UIColor whiteColor];
    
    return demoView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 97;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = catArray[indexPath.section];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"exhibition_id"]] forKey:@"EXI_ID"];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"exhibition_name"]] forKey:@"EXI_NAME"];
    
    ExciCatViewController *dashObj =[[ExciCatViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
}


- (IBAction)clickSearch:(id)sender {
    
    ExibitionSearchViewController *dashObj =[[ExibitionSearchViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
}


@end
