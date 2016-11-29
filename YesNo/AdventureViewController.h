//
//  AdventureViewController.h
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryManager.h"
#import "UserStateManager.h"
#import "Character.h"
#import "MainMenuViewController.h"

@interface AdventureViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate, StoryManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;

@property (strong, nonatomic) StoryManager *storyManager;
@property (strong, nonatomic) Character *mainCharacter;
@property (strong, nonatomic) UserStateManager *userStateManager;
@property BOOL isInAboutMode;

@end
