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

@interface StoryManager : UIViewController

@property (strong, nonatomic) SceneParser *parser;
@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) Tree *storyTree;
@property (strong, nonatomic) NSMutableArray *eventHistory;

-(id)initWithSceneName:(NSString *)sceneName andEvent:(Event *)event;
-(NSString *)getNextTextForChoice:(BOOL)choice;

@end
