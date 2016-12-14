//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "ExciListViewController.h"
#import "AFNetworking.h"
#include <math.h>

@interface ExciListViewController ()
{
    
    NSMutableArray *dataArray;
    NSMutableArray *viewsArray;
    NSMutableArray *catArray;
}
@end

@implementation ExciListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    self.navigationController.navigationBarHidden = TRUE;
    self.mapObj.showsUserLocation = YES;

    
   
    NSString *catId = [[NSUserDefaults standardUserDefaults]stringForKey:@"SUB_CAT_NAME"];
    
    _topLabel.text = catId;
    
    
    dataArray = [[NSMutableArray alloc]init];
    
    NSData *data2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"SLIDER_IMAGES"];
    
    NSArray *getImageData=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    
    
    [dataArray addObjectsFromArray:getImageData];
    
    NSString *catIdNew = [[NSUserDefaults standardUserDefaults]stringForKey:@"CAT_ID"];
    NSString *scatIdNew = [[NSUserDefaults standardUserDefaults]stringForKey:@"SUB_CAT_ID"];
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",catIdNew] forKey:@"catid"];
    [parameters setObject:[NSString stringWithFormat:@"%@",scatIdNew] forKey:@"scatid"];
    
    NSString *urlString=[NSString stringWithFormat:@"%@merchantpage_ads",ApiBaseURLNew];
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

    
    
    _mapObj.hidden = YES;
    _tblView.hidden = NO;
 
    
    [self gedatas];
    
}

-(void)gedatas
{
    [ProgressHUD show:nil];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:@"SUB_CAT_ID"];
    NSString *catId = [[NSUserDefaults standardUserDefaults]stringForKey:@"CAT_ID"];
    NSString *exiId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EXI_ID"];
    
    
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setObject:[NSString stringWithFormat:@"%@",catId] forKey:@"catid"];
    [parameters setObject:[NSString stringWithFormat:@"%@",userId] forKey:@"scatid"];
    [parameters setObject:[NSString stringWithFormat:@"%@",exiId] forKey:@"ex_id"];
    
    NSLog(@"Params:%@",parameters);
    
    NSString *urlString=[NSString stringWithFormat:@"%@allexhibitionstalls_with_category_subcategory_exhibitionid",ApiBaseURL];
    
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
            
            [catArray addObjectsFromArray:[JSON valueForKey:@"allshops"]];
            
            [ProgressHUD dismiss];
        }
        
        
        [_tblView reloadData];
        
        // [ProgressHUD dismiss];
        
        
        NSMutableArray *locArray = [[NSMutableArray alloc]init];
        
        for(int i=0;i< [catArray count];i++)
        {
            NSDictionary *dict = catArray[i];
            
            
            
            NSString *mainUrl = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"logoimage"]];
            
            
            
            
           // [cell1.imgAttach sd_setImageWithURL:[NSURL URLWithString:mainUrl] placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
            
            JPSThumbnail *empire = [[JPSThumbnail alloc] init];
            
            //[empire.image sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                             //  placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
            
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
            
            //NSLog(@"The distance is %@", convertDistanceToString(distance));
            

            

            //[empire.image sd_setImageWithURL:[NSURL URLWithString:mainUrl] placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
            
            
            /*
            [self processImageDataWithURLString:mainUrl andBlock:^(NSData *imageData) {
                if (self.view.window) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    
                    //empire.image = image;
                }
                
            }];*/
            
            
            empire.image = mainUrl;
            
            empire.title = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"name"]];
            empire.subtitle = [NSString stringWithFormat:@"%@ | %@",[dict valueForKey:@"state"], [NSString stringWithFormat:@"%.1f KM",(distance/1000)]];
            empire.coordinate = CLLocationCoordinate2DMake(newlatitude, newlongitude);
            empire.disclosureBlock = ^{
                
                NSLog(@"selected Empire:%@",[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"name"]]);
                
                
                
                
                
                ExiDetailViewController *dashObj =[[ExiDetailViewController alloc]init];
                dashObj.getshopId =[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
                [self.navigationController pushViewController:dashObj animated:YES];
            };

            [locArray addObject:[JPSThumbnailAnnotation annotationWithThumbnail:empire]];
        }
        
        
         [_mapObj addAnnotations:locArray];
        
        
        MKMapRect zoomRect = MKMapRectNull;
        for (id <MKAnnotation> annotation in _mapObj.annotations)
        {
            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
        [_mapObj setVisibleMapRect:zoomRect animated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
   
}


- (void)processImageDataWithURLString:(NSString *)urlString andBlock:(void (^)(NSData *imageData))processImage
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("com.myapp.processsmagequeue", NULL);
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(callerQueue, ^{
            processImage(imageData);
        });
    });
    //dispatch_release(downloadQueue);
    
    //dispatch_release(downloadQueue);
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
    
 
    ExiDetailViewController *dashObj =[[ExiDetailViewController alloc]init];
    dashObj.getshopId =[NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"id"]];
    [self.navigationController pushViewController:dashObj animated:YES];
}




- (IBAction)changeSlider:(id)sender {
    
    
    if(_slider.selectedSegmentIndex==0)
    {
        _mapObj.hidden = YES;
        _tblView.hidden = NO;
    }
    else
    {
        _mapObj.hidden = NO;
        _tblView.hidden = YES;
    }
    
}


- (IBAction)clickSearch:(id)sender {
    
    SearchListViewController *dashObj =[[SearchListViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    
}


#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)])
    {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

@end
