//
//  ReviewViewController.m
//  WescaleT
//
//  Created by SYZYGY on 18/10/16.
//  Copyright © 2016 PREMKUMAR. All rights reserved.
//

#import "CountryViewController.h"



@interface CountryViewController ()
{
    FavCellSmall *cell;
    
    NSMutableArray *dataArray;
    NSMutableArray *checkMarkArray;
    
    NSMutableArray *dataArraySub;
    NSMutableArray *checkMarkArraySub;
    
    
    NSMutableArray *dataArrayNew;
    NSMutableArray *checkMarkArrayNew;
    
    
    
    
    long long totalAmount;
    
    
    NSString *classId;
    NSString *subjectId;
    
    
    NSString *base64String;
    NSString *imageName;
}
@end

@implementation CountryViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [self.collectionViewFav registerNib:[UINib nibWithNibName:@"FavCellSmall" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
  
    
   
 
}




-(void)viewWillAppear:(BOOL)animated
{
    
   
    
    [ProgressHUD show:nil];
    
    
    
    
    
    NSString *urlString=[NSString stringWithFormat:@"%@allstates",ApiBaseURL];
    
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
            dataArray = [[NSMutableArray alloc]init];
            
            [dataArray addObjectsFromArray:[JSON valueForKey:@"allstates"]];
        }
        
        
        [_collectionViewFav reloadData];
        
        [ProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Error: %@", error);
        
        
        [ProgressHUD showError:error.localizedDescription];
        
        
    }];
    
    

    

}






- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    
    return [dataArray count];
}

- (FavCellSmall *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    cell.favView.layer.cornerRadius = 3;
    cell.favView.layer.masksToBounds = YES;
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    
    
    
    
    
    cell.lblTitle.text = [NSString stringWithFormat:@"%@",[dict valueForKeyPath:@"state_name"]];
   
    NSString *mainUrl=[NSString stringWithFormat:@"%@",[dict valueForKey:@"state_icon"]];
    
    [cell.iconFav sd_setImageWithURL:[NSURL URLWithString:mainUrl]
                placeholderImage:[UIImage imageNamed:@"default-placeholder.png"]];
    
    


    
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dict = dataArray[indexPath.row];
    
    
    
    

    
    [[NSUserDefaults standardUserDefaults]setObject:[dict valueForKey:@"state_name"] forKey:@"SELECTED_STATE"];
    
    
    SignupViewController *dashObj =[[SignupViewController alloc]init];
    [self.navigationController pushViewController:dashObj animated:YES];
    

   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 104);
}



- (IBAction)backBtn:(id)sender
{
   
            [self.navigationController popViewControllerAnimated:YES];
    
}




@end
