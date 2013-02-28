//
//  IMLoginViewController.m
//  IMClone
//
//  Created by Maxthon Chan on 13-3-1.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import "IMLoginViewController.h"
#import <MobileIMKit/IMKit.h>

@interface IMLoginViewController ()

@property UITextField *serverField;
@property UITextField *emailField;
@property UITextField *passwordField;

- (IBAction)login:(id)sender;

@end

@implementation IMLoginViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (![self.serverField.text length])
        [self.serverField becomeFirstResponder];
    else if (![self.emailField.text length])
        [self.emailField becomeFirstResponder];
    else
        [self.passwordField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch ([indexPath row])
    {
        case 0:
            cell.textLabel.text = @"Server";
            if (!self.serverField)
            {
                self.serverField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 210, 21)];
                self.serverField.placeholder = @"imcl://imcl.maxius.tk:12345/public";
                self.serverField.textColor = [UIColor colorWithRed:81.0/255.0
                                                             green:102.0/255.0
                                                              blue:145.0/255.0
                                                             alpha:1.0];
                self.serverField.textAlignment = NSTextAlignmentRight;
                self.serverField.keyboardType = UIKeyboardTypeURL;
                self.serverField.clearButtonMode = UITextFieldViewModeWhileEditing;
                self.serverField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                self.serverField.adjustsFontSizeToFitWidth = YES;
                self.serverField.autocorrectionType = UITextAutocorrectionTypeNo;
            }
            self.serverField.text = [defaults objectForKey:@"server"];
            cell.accessoryView = self.serverField;
            break;
        case 1:
            cell.textLabel.text = @"Email";
            if (!self.emailField)
            {
                self.emailField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 220, 21)];
                self.emailField.placeholder = @"steve@mac.com";
                self.emailField.textColor = [UIColor colorWithRed:81.0/255.0
                                                            green:102.0/255.0
                                                             blue:145.0/255.0
                                                            alpha:1.0];
                self.emailField.textAlignment = NSTextAlignmentRight;
                self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
                self.emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
                self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
                self.emailField.adjustsFontSizeToFitWidth = YES;
                self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
            }
            self.emailField.text = [defaults objectForKey:@"email"];
            cell.accessoryView = self.emailField;
            break;
        case 2:
            cell.textLabel.text = @"Password";
            if (!self.passwordField)
            {
                self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 180, 21)];
                self.passwordField.placeholder = @"password";
                self.passwordField.textColor = [UIColor colorWithRed:81.0/255.0
                                                               green:102.0/255.0
                                                                blue:145.0/255.0
                                                               alpha:1.0];
                self.passwordField.textAlignment = NSTextAlignmentRight;
                self.passwordField.secureTextEntry = YES;
                self.passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
            }
            self.passwordField.text = @"";
            cell.accessoryView = self.passwordField;
            break;
        default:
            break;
    }

}

- (void)login:(id)sender
{
    self.view.userInteractionEnabled = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.serverField.text forKey:@"server"];
    [defaults setObject:self.emailField.text forKey:@"email"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       dispatch_async(dispatch_get_main_queue(),
                                      ^{
                                          self.view.userInteractionEnabled = YES;
                                          if (![self.serverField.text length])
                                              [self.serverField becomeFirstResponder];
                                          else if (![self.emailField.text length])
                                              [self.emailField becomeFirstResponder];
                                          else
                                              [self.passwordField becomeFirstResponder];
                                      });
                   });
}

@end
