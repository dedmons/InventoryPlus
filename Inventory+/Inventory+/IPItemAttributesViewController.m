//
//  IPNewItemViewController.m
//  Inventory+
//
//  Created by Nick Watts on 8/25/12.
//  Copyright (c) 2012 Null Terminators. All rights reserved.
//

#import "IPItemAttributesViewController.h"

@interface IPItemAttributesViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IPInventoryItem *item;

@property (weak, nonatomic) UITextField *nameInput;
@property (weak, nonatomic) UITextView *descriptionInput;

@property (weak, nonatomic) UITextField *capacityField;
@property (weak, nonatomic) UITextField *desiredField;
@property (weak, nonatomic) UITextField *alertField;
@property (weak, nonatomic) UITextField *currentField;

@property (strong, nonatomic) NSMutableDictionary *stepperFields;
@property (strong, nonatomic) NSMutableDictionary *steppers;

@end

@implementation IPItemAttributesViewController

- (id)init
{
  self = [super initWithNibName:nil bundle:nil];
  if ( self ) {
    self.item = [[IPInventoryItem alloc] init];
    self.title = @"New Item";
  }
  return self;
}

- (id)initWithItem:(IPInventoryItem *)item
{
  self = [super initWithNibName:nil bundle:nil];
  if ( self ) {
    self.item = item;
    self.title = @"Edit Item";
  }
  return self;
}

- (UILabel *)makeLabelWithText:(NSString *)text afterElement:(UIView *)element
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  label.text = text;
  [label sizeToFit];
  label.frame = CGRectMake(10,
                           element.frame.origin.y + element.frame.size.height + 10,
                           self.view.frame.size.width - 20,
                           label.frame.size.height);
  [self.view addSubview:label];
  
  return label;
}

- (void)stepperDidStep:(UIStepper *)sender
{
  
  UITextField *field = [self.stepperFields objectForKey:[NSNumber numberWithInteger:sender.tag]];
  field.text = [NSString stringWithFormat:@"%.0lf", sender.value];
}

- (UITextField *)makeFieldWithStepperWithValue:(NSInteger)value afterElement:(UIView *)element
{
  static NSInteger tag = 0;
  tag++;
  
  UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
  textField.borderStyle = UITextBorderStyleRoundedRect;
  [textField sizeToFit];
  
  UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
  [stepper sizeToFit];
  stepper.frame = CGRectMake(self.view.frame.size.width - 10 - stepper.frame.size.width,
                             element.frame.origin.y + element.frame.size.height + 10,
                             stepper.frame.size.width,
                             stepper.frame.size.height);
  
  textField.frame = CGRectMake(10,
                               element.frame.origin.y + element.frame.size.height + 10,
                               self.view.frame.size.width - 30 - stepper.frame.size.width,
                               textField.frame.size.height);
  
  [self.view addSubview:textField];
  [self.view addSubview:stepper];
  
  textField.text = [NSString stringWithFormat:@"%d", value];
  stepper.value = value;
  
  stepper.tag = tag;
  [self.stepperFields setObject:textField forKey:[NSNumber numberWithInteger:tag]];
  [self.steppers setObject:stepper forKey:[NSNumber numberWithInteger:tag]];
  
  textField.delegate = self;
  textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
  textField.returnKeyType = UIReturnKeyDone;
  
  [stepper addTarget:self action:@selector(stepperDidStep:) forControlEvents:UIControlEventValueChanged];
  
  return textField;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
  self.view.backgroundColor = [UIColor whiteColor];
  
  UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  nameLabel.text = @"Name:";
  [nameLabel sizeToFit];
  nameLabel.frame = CGRectMake(10,
                               10,
                               self.view.frame.size.width - 20,
                               nameLabel.frame.size.height);
  [self.view addSubview:nameLabel];
  
  UITextField *nameInput = [[UITextField alloc] initWithFrame:CGRectZero];
  nameInput.borderStyle = UITextBorderStyleRoundedRect;
  [nameInput sizeToFit];
  nameInput.delegate = self;
  nameInput.returnKeyType = UIReturnKeyDone;
  nameInput.frame = CGRectMake(10,
                               nameLabel.frame.origin.y + nameLabel.frame.size.height + 10,
                               self.view.frame.size.width - 20,
                               nameLabel.frame.origin.y + nameLabel.frame.size.height);
  self.nameInput = nameInput;
  [self.view addSubview:nameInput];
  
  UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  descriptionLabel.text = @"Description:";
  [descriptionLabel sizeToFit];
  descriptionLabel.frame = CGRectMake(10,
                                      nameInput.frame.origin.y + nameInput.frame.size.height + 10,
                                      self.view.frame.size.width - 20,
                                      descriptionLabel.frame.size.height);
  [self.view addSubview:descriptionLabel];
  
  UITextView *descriptionInput = [[UITextView alloc] initWithFrame:CGRectZero];
  descriptionInput.frame = CGRectMake(10,
                                      descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height + 10,
                                      self.view.frame.size.width - 20,
                                      nameInput.frame.size.height * 3);
  descriptionInput.font = nameInput.font;
  descriptionInput.delegate = self;
  descriptionInput.returnKeyType = UIReturnKeyDone;
  descriptionInput.layer.borderWidth = 2.0;
  descriptionInput.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
  descriptionInput.layer.masksToBounds = YES;
  descriptionInput.layer.cornerRadius = 5.0;
  self.descriptionInput = descriptionInput;
  [self.view addSubview:descriptionInput];
  
  self.stepperFields = [NSMutableDictionary dictionary];
  self.steppers = [NSMutableDictionary dictionary];
  
  UILabel *capacityLabel = [self makeLabelWithText:@"Capacity:" afterElement:self.descriptionInput];
  
  UITextField *capacityField = [self makeFieldWithStepperWithValue:self.item.capacity
                                                      afterElement:capacityLabel];
  self.capacityField = capacityField;
  
  UILabel *desiredLabel = [self makeLabelWithText:@"Desired Inventory" afterElement:capacityField];
  
  UITextField *desiredField = [self makeFieldWithStepperWithValue:self.item.desiredInventory
                                                     afterElement:desiredLabel];
  self.desiredField = desiredField;
  
  UILabel *alertLabel = [self makeLabelWithText:@"Alert Inventory Level" afterElement:desiredField];
  
  UITextField *alertField = [self makeFieldWithStepperWithValue:self.item.alertInventory
                                                   afterElement:alertLabel];
  self.alertField = alertField;
  
  UILabel *currentLabel = [self makeLabelWithText:@"Current Inventory" afterElement:alertField];
  
  UITextField *currentField = [self makeFieldWithStepperWithValue:self.item.currentInventory
                                                     afterElement:currentLabel];
  self.currentField = currentField;
  
  UISegmentedControl *submitButton = [[UISegmentedControl alloc] initWithItems:@[ @"Submit" ]];
  submitButton.momentary = YES;
  submitButton.tintColor = [UIColor greenColor];
  submitButton.segmentedControlStyle = UISegmentedControlStyleBar;

  NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:17.0]
                                                         forKey:UITextAttributeFont];
  [submitButton setTitleTextAttributes:attributes
                              forState:UIControlStateNormal];
  [submitButton sizeToFit];
  submitButton.frame = CGRectMake(10,
                                  currentField.frame.origin.y + currentField.frame.size.height + 10,
                                  self.view.frame.size.width - 20,
                                  submitButton.frame.size.height);
  [self.view addSubview:submitButton];
  
  [submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventValueChanged];
  
  ((UIScrollView *) self.view).contentSize = CGSizeMake(self.view.frame.size.width,
                                                        submitButton.frame.origin.y + submitButton.frame.size.height + 10);
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [textField resignFirstResponder];
  return YES;
}

#pragma mark - Text view delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
  if ( [text isEqualToString:@"\n"] ) {
    [textView resignFirstResponder];
  }
  return YES;
}

#pragma mark - Submit

- (void)submitButtonPressed:(UIButton *)sender
{
  NSLog(@"submit item");
  NSLog(@"name: %@", self.nameInput.text);
  NSLog(@"description: %@", self.descriptionInput.text);
  NSLog(@"current: %d", self.currentField.text.integerValue);
  NSLog(@"capacity: %d", self.capacityField.text.integerValue);
  NSLog(@"desired: %d", self.desiredField.text.integerValue);
  NSLog(@"alert: %d", self.alertField.text.integerValue);
}

@end
