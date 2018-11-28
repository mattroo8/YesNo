//
//  StoryCharacter.m
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "StoryCharacter.h"

@implementation StoryCharacter

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.firstName forKey:@"firstName"];
    [encoder encodeObject:self.lastName forKey:@"lastName"];
    [encoder encodeObject:self.age forKey:@"age"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.currentStory forKey:@"currentStory"];
    [encoder encodeObject:self.currentEvent forKey:@"currentEvent"];
    [encoder encodeObject:self.eventHistory forKey:@"eventHistory"];
    [encoder encodeInt:self.currentEventIndex forKey:@"currentEventIndex"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.firstName = [decoder decodeObjectForKey:@"firstName"];
        self.lastName = [decoder decodeObjectForKey:@"lastName"];
        self.age = [decoder decodeObjectForKey:@"age"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.currentStory = [decoder decodeObjectForKey:@"currentStory"];
        self.currentEvent = [decoder decodeObjectForKey:@"currentEvent"];
        self.eventHistory = [decoder decodeObjectForKey:@"eventHistory"];
        self.currentEventIndex = [decoder decodeIntForKey:@"currentEventIndex"];
    }
    return self;
}

@end
