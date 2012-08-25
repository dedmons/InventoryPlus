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

@end

@implementation IPStartViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)logout:(id)sender {
    [PFUser logOut];
    [self checkLoginStatus];
}
@end
