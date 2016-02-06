//
//  StoryManager.m
//  YesNo
//
//  Created by Matt Rooney on 23/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "StoryManager.h"

@implementation StoryManager

-(id)initWithSceneName:(NSString *)sceneName andEvent:(Event *)event {
    if ( self = [super init] ) {
        _currentEvent = event;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventsReceived:)
                                                     name:@"EventsReceivedNotification"
                                                   object:nil];
        [self parseNewScene:sceneName];
    }
    return self;
}

-(NSString *)getNextTextForChoice:(BOOL)choice
{
    _currentEvent.answer = choice ? @"yes" : @"no";
    Event *event = [_storyTree getNextEventForChoice:choice];
    _currentEvent = event;
    _currentEvent.answer = choice ? @"yes" : @"no";
    if(_currentEvent.isScene){
        [self parseNewScene:_currentEvent.eventText];
    }
    return _currentEvent.eventText;
}

-(void)eventsReceived:(NSNotification*)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSMutableArray *events = [userInfo objectForKey:@"events"];
    _storyTree = [Tree new];
    for(Event *event in events){
        [_storyTree insertNodeWithEvent:event];
    }
    if(!_currentEvent || _currentEvent.isScene){
        _currentEvent = [Event new];
        _currentEvent = _storyTree.root.event;
    } else {
        [_storyTree searchNodeForKey:_currentEvent.key];
    }
}

-(void)parseNewScene:(NSString *)scene
{
    _parser = [SceneParser new];
    [_parser startParsingFile:scene];
}

@end
