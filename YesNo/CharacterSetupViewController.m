//
//  CharacterSetupViewController.m
//  YesNo
//
//  Created by Matt Rooney on 11/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "CharacterSetupViewController.h"
#import "AdventureViewController.h"
#import "UserStateManager.h"

@interface CharacterSetupViewController ()

@property (strong,nonatomic)UserStateManager *usm;

@end

@implementation CharacterSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _usm = [UserStateManager sharedUserStateManager];
    [self registerForKeyboardNotifications];
    _firstNameTextField.delegate = self;
    _lastNameTextField.delegate = self;
    _ageTextField.delegate = self;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]
                     initWithTarget:self.view
                             action:@selector(endEditing:)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continuePressed:(id)sender {
    
        NSString *message = nil;
        BOOL showAlert = NO;
        
        if(!_firstNameTextField.text || [_firstNameTextField.text length]==0){
            message = @"Please enter your first name";
            showAlert = YES;
        } else if(!_lastNameTextField.text || [_lastNameTextField.text length]==0){
            message = @"Please enter your last name";
            showAlert = YES;
        } else if(!_ageTextField.text || [_ageTextField.text length]==0){
            message = @"Please enter your age";
            showAlert = YES;
        } else {
            NSLog(@"All details filled in");
        }
    
    if(showAlert){
        
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Missing Information"
                                    message:message
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction
                                        actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    _usm.mainCharacter = [Character new];
    _usm.mainCharacter.firstName = _firstNameTextField.text;
    _usm.mainCharacter.lastName = _lastNameTextField.text;
    _usm.mainCharacter.age = _ageTextField.text;
    _usm.mainCharacter.sex = [_sexSegmentedControl titleForSegmentAtIndex:_sexSegmentedControl.selectedSegmentIndex];
    _usm.mainCharacter.currentStory = @"morningscene";
    _usm.mainCharacter.eventHistory = [NSMutableArray new];
    _usm.mainCharacter.currentEvent = nil;
    _usm.mainCharacter.currentEventIndex = 0;
    
    [_usm saveCharacter:_usm.mainCharacter];
    AdventureViewController *advc = [AdventureViewController new];
    advc.presentedFromCharacterSetup = YES;
    [self.navigationController pushViewController:advc animated:YES];
}
- (IBAction)backPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    if(_ageTextField.editing == YES){
        CGRect aRect = self.view.frame;
        aRect.size.height -= kbSize.height;
        if (!CGRectContainsPoint(aRect, _ageTextField.frame.origin) ) {
            CGPoint scrollPoint = CGPointMake(0.0, _ageTextField.frame.origin.y-kbSize.height);
            [_scrollView setContentOffset:scrollPoint animated:YES];
        }
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    // do not allow the first character to be space | do not allow more than one space
    if ([string isEqualToString:@" "]) {
        if (!textField.text.length)
            return NO;
        if ([[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length)
            return NO;
    }
    // allow backspace
    if ([textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length) {
        return YES;
    }
    if ([textField.text stringByReplacingCharactersInRange:range withString:string].length > 30) {
        return NO;
    }
    NSCharacterSet *set = [NSCharacterSet new];
    if(textField != _ageTextField){
        set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
    } else {
        set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    }
    if ([string rangeOfCharacterFromSet:set].location == NSNotFound) {
        return NO;
    }
    return YES;
}

@end
