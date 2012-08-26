//
//  IPInventoryViewController.m
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPInventoryViewController.h"
@interface IPInventoryViewController ()

@end

@implementation IPInventoryViewController

@synthesize name;
@synthesize description;
@synthesize count;
@synthesize updateButton;
@synthesize item;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setValuesToLabel];
    self.view.backgroundColor = [UIColor colorWithRed:.48 green:.48 blue:.48 alpha:1.0];

}

-(void)setValuesToLabel{
    NSLog(@"%@",self.item.name);
    self.name.text = self.item.name;
    
    self.description.text = self.item.description;
    
    NSInteger ht = [self getHeightForText:self.item.description OfFont:[UIFont systemFontOfSize:14]  forWidth:280];
    
    
    
    self.description.frame = CGRectMake(self.description.frame.origin.x
                                             , self.description.frame.origin.y, 280, ht);
    
    
    
    
    self.count.text = [NSString stringWithFormat:@"%d", self.item.currentInventory];
    
    self.count.frame = CGRectMake(self.count.frame.origin.x,
                                  self.description.frame.origin.y + self.description.frame.size.height + 20,
                                  self.count.frame.size.width,
                                  self.count.frame.size.height);
    
    
    self.stepper.value = self.item.currentInventory;
    self.stepper.frame = CGRectMake(self.stepper.frame.origin.x,
                                    self.description.frame.origin.y + self.description.frame.size.height + 20,
                                    self.stepper.frame.size.width,
                                    self.stepper.frame.size.height);
    
    
    
    self.updateButton.frame = CGRectMake(self.updateButton.frame.origin.x,
                                         self.count.frame.origin.y + self.count.frame.size.height + 20,
                                         self.updateButton.frame.size.width,
                                         self.updateButton.frame.size.height);
    
      
  

}

- (NSInteger)getHeightForText:(NSString *)string OfFont:(UIFont *)font forWidth:(CGFloat)width{
    CGSize constraintSize;
	
    constraintSize.width = width;
	
    constraintSize.height = MAXFLOAT;
    
    CGSize stringSize =[string sizeWithFont: font  constrainedToSize:constraintSize lineBreakMode: UILineBreakModeWordWrap];
    
    return stringSize.height + 20;
	
    
    
}


-(IBAction)doChangeCount:(id)sender{
    int x = self.stepper.value;
    
    self.count.text = [NSString stringWithFormat:@"%d", x];
}

-(IBAction)doUpdate:(id)sender{
    self.item.currentInventory = self.stepper.value;
    [self.item saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!succeeded) {
            NSLog(@"unsuccessful save");
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Unable to update. Please try again or contact Customer service."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
            [a show];

           
        }else{
            NSLog(@"successful save");
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message:@"Inventory was updated successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
            [a show];

        }
    }];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
