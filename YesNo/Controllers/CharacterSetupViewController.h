//
//  CharacterSetupViewController.h
//  YesNo
//
//  Created by Matt Rooney on 11/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuNavDelegate.h"

@interface CharacterSetupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewContentView;

@property (weak, nonatomic) id <MainMenuNavDelegate> delegate;

@end
