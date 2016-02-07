//
//  AdventureViewController.m
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "AdventureViewController.h"

@interface AdventureViewController ()

@property (strong, nonatomic) NSString *enteredText;
@property int currentIndex;

@end

@implementation AdventureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentIndex = 0;
    self.textView.editable = NO;
    self.enteredText = @"";
    _userStateManager = [UserStateManager sharedUserStateManager];
    _storyManager = [[StoryManager alloc]initWithSceneName:_userStateManager.mainCharacter.currentStory andEvent:_userStateManager.mainCharacter.currentEvent];
    _userStateManager.mainCharacter.currentEvent = _storyManager.currentEvent;
    _forwardButton.hidden = YES;
    if(![_userStateManager.mainCharacter.eventHistory count]>0){
        _backButton.hidden = YES;
        [_userStateManager.mainCharacter.eventHistory addObject:_storyManager.currentEvent];
        _currentIndex++;
    } else {
        _currentIndex = (int)[_userStateManager.mainCharacter.eventHistory count]-1;
        _backButton.hidden = NO;
    }
    self.textView.text = _userStateManager.mainCharacter.currentEvent.eventText;
    [self resetScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choicePressed:(id)sender {
    
    NSString *eventText = @"";
    BOOL choice;
    UIButton *button = (UIButton*)sender;
    if (button.tag == 1) {
        choice = YES;
    } else if (button.tag == 2) {
        choice = NO;
    } else {
        NSLog(@"Button not identified");
    }
    eventText = [_storyManager getNextTextForChoice:choice];
    _userStateManager.mainCharacter.currentEvent = _storyManager.currentEvent;
    if(_storyManager.currentEvent){
        [_userStateManager.mainCharacter.eventHistory addObject:_storyManager.currentEvent];
    }
    _currentIndex = (int)[_userStateManager.mainCharacter.eventHistory count]-1;
    _backButton.hidden = NO;
    _textView.text = eventText;
    [self resetScrollView];
}

- (IBAction)goToMainMenu:(id)sender
{
    [_userStateManager saveCharacter:_userStateManager.mainCharacter];
    [self presentViewController:[MainMenuViewController new] animated:NO completion:nil];
}

- (IBAction)backButtonPressed:(id)sender {
    _forwardButton.hidden = NO;
    _currentIndex--;
    Event *event;
    if([_userStateManager.mainCharacter.eventHistory count]>=_currentIndex){
        event = [_userStateManager.mainCharacter.eventHistory objectAtIndex:_currentIndex];
    }
    if(_currentIndex == 0){
        _backButton.hidden = YES;
    }
    if([event.answer boolValue]){
        _noButton.hidden = YES;
        _yesButton.hidden = NO;
        _yesButton.enabled = NO;
    } else {
        _yesButton.hidden = YES;
        _noButton.hidden = NO;
        _noButton.enabled = NO;
    }
    _textView.text = event.eventText;
    [self resetScrollView];
}

- (IBAction)forwardButtonPressed:(id)sender {
    _backButton.hidden = NO;
    _currentIndex++;
    Event *event;
    if([_userStateManager.mainCharacter.eventHistory count]>=_currentIndex){
        event = [_userStateManager.mainCharacter.eventHistory objectAtIndex:_currentIndex];
    }
    if(_currentIndex == [_userStateManager.mainCharacter.eventHistory count]-1){
        _forwardButton.hidden = YES;
        _yesButton.hidden = NO;
        _noButton.hidden = NO;
        _yesButton.enabled = YES;
        _noButton.enabled = YES;
    } else {
        if([event.answer boolValue]){
            _noButton.hidden = YES;
            _yesButton.hidden = NO;
            _yesButton.enabled = NO;
        } else {
            _yesButton.hidden = YES;
            _noButton.hidden = NO;
            _noButton.enabled = NO;
        }
    }
    _textView.text = event.eventText;
    [self resetScrollView];
}

-(void)resetScrollView
{
    [_textView setContentOffset:CGPointMake(_scrollView.contentOffset.x, (-1) * _scrollView.contentInset.top) animated:NO];
}



@end
