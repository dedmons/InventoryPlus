//
//  IPLocationViewController.m
//  Inventory+
//
//  Created by Akash Mudubagilu on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPLocationViewController.h"

@interface IPLocationViewController ()

@end

@implementation IPLocationViewController
@synthesize nameLabel;
@synthesize descriptionLabel;
@synthesize aisleLabel;
@synthesize sectionLabel;
@synthesize item;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)setLabels{
    
    NSLog(@"%@",self.item.name);
    self.nameLabel.text = self.item.name;
    
    self.descriptionLabel.text = self.item.description;
    
    NSInteger ht = [self getHeightForText:self.item.description OfFont:[UIFont systemFontOfSize:14]  forWidth:280];
    

    
    self.descriptionLabel.frame = CGRectMake(self.descriptionLabel.frame.origin.x
                                             , self.descriptionLabel.frame.origin.y, 280, ht);
    
    
    
    self.aisleLabel.text = [NSString stringWithFormat:@"Aisle : %d", self.item.aisle] ;
    self.aisleLabel.frame = CGRectMake(self.aisleLabel.frame.origin.x,
                                       self.descriptionLabel.frame.origin.y
                                       + ht + 20, self.aisleLabel.frame.size.width, self.aisleLabel.frame.size.height);
    
    
    self.sectionLabel.text =  [NSString stringWithFormat:@"Section : %d", self.item.section];
    
    self.sectionLabel.frame =  CGRectMake(self.sectionLabel.frame.origin.x,
               self.aisleLabel.frame.origin.y
               + self.aisleLabel.frame.size.height + 20, self.sectionLabel.frame.size.width, self.sectionLabel.frame.size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLabels];
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


- (NSInteger)getHeightForText:(NSString *)string OfFont:(UIFont *)font forWidth:(CGFloat)width{
    CGSize constraintSize;
	
    constraintSize.width = width;
	
    constraintSize.height = MAXFLOAT;
    
    CGSize stringSize =[string sizeWithFont: font  constrainedToSize:constraintSize lineBreakMode: UILineBreakModeWordWrap];
    
    return stringSize.height + 20;
	
    
    
}


@end
