//
//  StoryManager.h
//  YesNo
//
//  Created by Matt Rooney on 23/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneParser.h"
#import "Event.h"
#import "Tree.h"
#import "UserStateManager.h"
#import "StoryManagerDelegate.h"

@interface StoryManager: NSObject

@property (strong, nonatomic) SceneParser *parser;
@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) Tree *storyTree;
@property (strong, nonatomic) StoryCharacter *mainCharacter;

@property (nonatomic, weak) id<StoryManagerDelegate> delegate;

-(id)init;
-(void)setupStory:(StoryCharacter*)mainCharacter;
-(void)getNextTextForChoice:(DecisionEnum)choice;
-(NSString *)getPastEventTextForDirection:(BOOL)isForwardDirection;
-(void)saveState;

@end
