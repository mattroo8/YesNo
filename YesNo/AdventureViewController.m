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
    } else {
        NSLog(@"Button not identified");
    }
    [_storyManager getNextTextForChoice:choice];
}

- (IBAction)goToMainMenu:(id)sender
{
    [_storyManager saveState];
    if(_presentedFromCharacterSetup){
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)backButtonPressed:(id)sender
{
    BOOL isForwardDirection = NO;
    _textView.text = [_storyManager getPastEventTextForDirection:isForwardDirection];
    [self resetScrollView];
}

- (IBAction)forwardButtonPressed:(id)sender
{
    BOOL isForwardDirection = YES;
    _textView.text = [_storyManager getPastEventTextForDirection:isForwardDirection];
    [self resetScrollView];
}

-(void)resetScrollView
{
    [_textView setContentOffset:CGPointMake(_scrollView.contentOffset.x, (-1) * _scrollView.contentInset.top) animated:NO];
}

-(void)showYesButtonForStoryView:(BOOL)yesButton
                     andNoButton:(BOOL)noButton
                   andBackButton:(BOOL)backButton
                andForwardButton:(BOOL)forwardButton
{
    NSLog(@"MATT TEST: backButton is now: %@",backButton ? @"YES" : @"NO");
    
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
    [self resetScrollView];
}




@end
