//
//  IPViewController.m
//  Inventory+
//
//  Created by Douglas Edmonson on 08/25/2012.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPStartViewController.h"
#import "IPUser.h"

@interface IPStartViewController ()

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
    self.addButton.hidden = YES;
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
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Welcome!"
                                                    message:[NSString stringWithFormat:@"Loged in as %@ with Role %d", [IPUser currentUser].userName, [IPUser currentUser].role]
                                                   delegate:nil
                                          cancelButtonTitle:@"Thanks"
                                          otherButtonTitles:nil];
        [a show];
    }
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([IPUser currentUser].role == IPManagerUser) {
        self.addButton.hidden = NO;
    }
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

@end
