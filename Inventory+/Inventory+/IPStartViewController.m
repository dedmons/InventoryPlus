//
//  IPViewController.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPStartViewController.h"
#import "IPUser.h"

@interface IPStartViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation IPStartViewController
@synthesize addButton;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkLoginStatus];
}

- (void)checkLoginStatus{
    if (![IPUser currentUser]) {
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        logInController.fields = PFLogInFieldsLogInButton|PFLogInFieldsUsernameAndPassword|PFLogInFieldsPasswordForgotten;
      [self presentViewController:logInController animated:YES completion:nil];
    } else {
        if ([IPUser currentUser].role == IPManagerUser) {
            self.addButton.hidden = NO;
        } else {
            self.addButton.hidden = YES;
        }

    }
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
  
  UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                              message:[NSString stringWithFormat:@"Loged in as %@ with Role %d", [IPUser currentUser].userName, [IPUser currentUser].role]
                                             delegate:nil
                                    cancelButtonTitle:@"Thanks"
                                    otherButtonTitles:nil];
  [a show];
  [self.tableView reloadData];
  
}

- (void)viewDidUnload {
    [self setAddButton:nil];
    [super viewDidUnload];
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self checkLoginStatus];
}

-(IBAction)scann {
    NSLog(@"SCAN");
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ScannerView"] animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (([IPUser currentUser].role == IPManagerUser) ? 3 : 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  
  UIImageView *imageView = nil;
  
  UILabel *label = nil;
  if ( ! cell ) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.tag = 1;
    [cell.contentView addSubview:imageView];
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.backgroundColor = [UIColor clearColor];
    label.tag = 2;
    [cell.contentView addSubview:label];
  }
  
  if ( ! imageView )
    imageView = (UIImageView *) [cell.contentView viewWithTag:1];
  
  if ( ! label )
    label = (UILabel *) [cell.contentView viewWithTag:2];
  
  [imageView setFrame:CGRectMake(10, 10, 64, 64)];
  
  switch (indexPath.row) {
    case 0:
      imageView.image = [UIImage imageNamed:@"qr.png"];
      label.text = @"Scan";
      break;
    case 1:
      imageView.image = [UIImage imageNamed:@"search.png"];
      label.text = @"Search";
      break;
    case 2:
      imageView.image = [UIImage imageNamed:@"Add.png"];
      label.text = @"New Item";
      break;
    default:
      
      break;
  }
  
  label.frame = CGRectMake(104, 28, 150, 30);
  
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 84;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  switch (indexPath.row) {
    case 0:
      [self performSegueWithIdentifier:@"StartToScan" sender:nil];
      break;
    case 1:
      [self performSegueWithIdentifier:@"StartToSearch" sender:nil];
      break;
    case 2:
      [self performSegueWithIdentifier:@"StartToNew" sender:nil];
      
      break;
      
    default:
      break;
  }
}

@end
