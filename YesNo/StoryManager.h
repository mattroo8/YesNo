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

@interface StoryManager : UIViewController

@property (strong, nonatomic) SceneParser *parser;
@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) Tree *storyTree;
@property (strong, nonatomic) UserStateManager *userStateManager;

@property (nonatomic, weak) id<StoryManagerDelegate> delegate;

-(id)init;
-(void)setupStory;
-(void)getNextTextForChoice:(BOOL)choice;
-(NSString *)getPastEventTextForDirection:(BOOL)isForwardDirection;
-(void)saveState;

@end
