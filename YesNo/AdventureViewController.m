//
//  AdventureViewController.m
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "AdventureViewController.h"

@interface AdventureViewController ()

@end

@implementation AdventureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _storyManager = [[StoryManager alloc]init];
    _storyManager.delegate = self;
    [_storyManager setupStory];
    [_textView setEditable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choicePressed:(id)sender {
    
    BOOL choice;
    UIButton *button = (UIButton*)sender;
    if (button.tag == 1) {
        choice = YES;
    } else if (button.tag == 2) {
        choice = NO;
    }
    [_storyManager getNextTextForChoice:choice];
}

- (IBAction)goToMainMenu:(id)sender
{
    [_storyManager saveState];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)backButtonPressed:(id)sender
{
    BOOL isForwardDirection = NO;
    _textView.text = [_storyManager getPastEventTextForDirection:isForwardDirection];
}

- (IBAction)forwardButtonPressed:(id)sender
{
    BOOL isForwardDirection = YES;
    _textView.text = [_storyManager getPastEventTextForDirection:isForwardDirection];
}

-(void)showYesButtonForStoryView:(BOOL)yesButton
                     andNoButton:(BOOL)noButton
                   andBackButton:(BOOL)backButton
                andForwardButton:(BOOL)forwardButton
{    
    _yesButton.hidden = !yesButton;
    _noButton.hidden = !noButton;
    _yesButton.enabled = yesButton && noButton;
    _noButton.enabled = yesButton && noButton;
    _backButton.hidden = !backButton;
    _forwardButton.hidden = !forwardButton;
}

-(void)setTextForStoryView:(NSString *)text
{
    _textView.text = text;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}




@end
