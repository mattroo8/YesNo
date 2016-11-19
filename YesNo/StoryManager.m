//
//  StoryManager.m
//  YesNo
//
//  Created by Matt Rooney on 23/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "StoryManager.h"

@interface StoryManager()

@property int currentIndex;

@end

@implementation StoryManager

-(id)init {
    if ( self = [super init] ) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventsReceived:)
                                                     name:@"EventsReceivedNotification"
                                                   object:nil];        
        _mainCharacter = [[UserStateManager sharedUserStateManager]loadCharacter];
    }
    return self;
}

-(void)getNextTextForChoice:(DecisionEnum)decision
{
    _currentEvent.decision = decision;
    Event *event = [_storyTree getNextEventForChoice:decision];
    if(event.isScene){
        [self parseNewScene:event.eventText];
    } else if(event.isEnding){
        NSString *uniqueId = [_mainCharacter.firstName stringByAppendingString:[[NSUUID UUID] UUIDString]];
        _currentEvent.eventText = [event.eventText stringByReplacingOccurrencesOfString:@"UUID"
                                                                 withString:uniqueId];

        [_delegate showYesButtonForStoryView:NO andNoButton:NO andBackButton:NO andForwardButton:NO];
        [_delegate setTextForStoryView:_currentEvent.eventText];
    } else {
        _currentEvent = event;
        [_mainCharacter.eventHistory addObject:_currentEvent];
        _mainCharacter.currentEventIndex++;
        [_delegate setTextForStoryView:_currentEvent.eventText];
        [self updateStoryViewButtons];
    }
}

-(void)eventsReceived:(NSNotification*)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSMutableArray *events = [userInfo objectForKey:@"events"];
    _storyTree = [Tree new];
    for(Event *event in events){
        [_storyTree insertNodeWithEvent:event];
    }
    if(!_mainCharacter.currentEvent){
        _currentEvent = [Event new];
        _currentEvent = _storyTree.root.event;
        [_mainCharacter.eventHistory addObject:_currentEvent];
        if(_mainCharacter.currentEventIndex != 0){
            _mainCharacter.currentEventIndex++;
        }
    } else {
        _currentEvent = _mainCharacter.currentEvent;
    }
    [_delegate setTextForStoryView:_currentEvent.eventText];
    [self updateStoryViewButtons];
}

-(void)parseNewScene:(NSString *)scene
{
    _parser = [SceneParser new];
    [_parser startParsingFile:scene];
}

-(NSString *)getPastEventTextForDirection:(BOOL)isForwardDirection
{
    if(isForwardDirection){
        _mainCharacter.currentEventIndex++;
    } else {
        _mainCharacter.currentEventIndex--;
    }
    Event *event = [Event new];
    if([_mainCharacter.eventHistory count]-1>=_mainCharacter.currentEventIndex){
        event = [_mainCharacter.eventHistory objectAtIndex:_mainCharacter.currentEventIndex];
        [self updateStoryViewButtons];
    }
    return event.eventText;
}

-(void)updateStoryViewButtons
{
    BOOL showYesButton = NO;
    BOOL showNoButton = NO;
    BOOL showForwardButton = NO;
    BOOL showBackButton = NO;
    
    NSLog(@"MATT TEST: Event history count - %lu",(unsigned long)[_mainCharacter.eventHistory count]);
    NSLog(@"MATT TEST: Current Index - %lu",(unsigned long)_mainCharacter.currentEventIndex);
    if(_mainCharacter.currentEvent.isEnding){
        showYesButton = NO;
        showNoButton = NO;
        showBackButton = YES;
        showForwardButton = NO;
    }
    //We are at the very beginning of the story
    else if([_mainCharacter.eventHistory count]==1 && _mainCharacter.currentEventIndex == 0){
        showYesButton = YES;
        showNoButton = YES;
        showForwardButton = NO;
    } else {
        Event *event = [Event new];
        if([_mainCharacter.eventHistory count]>=_mainCharacter.currentEventIndex){
            event = [_mainCharacter.eventHistory objectAtIndex:_mainCharacter.currentEventIndex];
        }
        //We are somewhere in the middle
        if(_mainCharacter.currentEventIndex < [_mainCharacter.eventHistory count]-1 && _mainCharacter.currentEventIndex !=0){
            if(event.decision == YesDecision){
                showYesButton = YES;
                showNoButton = NO;
            } else {
                showYesButton = NO;
                showNoButton = YES;
            }
            showBackButton = YES;
            showForwardButton = YES;
        }
        //We are at the beginning but we have started the story
        else if([_mainCharacter.eventHistory count]>1 && _mainCharacter.currentEventIndex == 0){
            if(event.decision == YesDecision){
                showYesButton = YES;
                showNoButton = NO;
            } else {
                showYesButton = NO;
                showNoButton = YES;
            }
            showBackButton = NO;
            showForwardButton = YES;
        }
        //We are at the current event and have started the story
        else if([_mainCharacter.eventHistory count]-1 == _mainCharacter.currentEventIndex){
            showYesButton = YES;
            showNoButton = YES;
            showBackButton = YES;
            showForwardButton = NO;
        }
    }
    NSLog(@"MATT TEST: show back button is: %@",showBackButton ? @"YES" : @"NO");
    [_delegate showYesButtonForStoryView:showYesButton
                             andNoButton:showNoButton
                           andBackButton:showBackButton
                        andForwardButton:showForwardButton];
}

-(void)setupStory
{
    [self parseNewScene:_mainCharacter.currentStory];
}

-(void)saveState
{
    _mainCharacter.currentEvent = _currentEvent;
    [_userStateManager saveCharacter:_mainCharacter];
}

@end
