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
    if(!_isInAboutMode){
        _storyManager = [[StoryManager alloc] init];
        _storyManager.delegate = self;
        [_storyManager setupStory];
    } else {
        [self showYesButtonForStoryView:NO andNoButton:NO andBackButton:NO andForwardButton:NO];
        _textView.text = @"The objective of this game is to try to stay alive. There is only one sequence of decisions which will keep you alive. Good luck.";
    }
    [_textView setEditable:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choicePressed:(id)sender {
    
    UIButton *button = (UIButton*)sender;
    [_storyManager getNextTextForChoice:button.tag == 1];
}

- (IBAction)goToMainMenu:(id)sender
{
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

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(!_isInAboutMode){
        [_storyManager saveState];
    }
}

@end
