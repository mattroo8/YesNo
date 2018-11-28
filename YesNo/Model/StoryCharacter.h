//
//  StoryCharacter.h
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface StoryCharacter : NSObject <NSCoding>

@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *age;
@property (strong,nonatomic) NSString *sex;
@property (strong,nonatomic) NSString *currentStory;
@property (strong,nonatomic) Event *currentEvent;
@property (strong,nonatomic) NSMutableArray *eventHistory;
@property int currentEventIndex;

@end
