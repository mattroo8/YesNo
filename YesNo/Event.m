//
//  Event.m
//  YesNo
//
//  Created by Matt Rooney on 20/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "Event.h"

@implementation Event

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.eventText forKey:@"eventText"];
    [encoder encodeBool:self.answer forKey:@"answer"];
    [encoder encodeInt:self.key forKey:@"key"];
    [encoder encodeBool:self.isScene forKey:@"isScene"];
    [encoder encodeBool:self.isEnding forKey:@"isEnding"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.eventText = [decoder decodeObjectForKey:@"eventText"];
        self.answer = [decoder decodeBoolForKey:@"answer"];
        self.key = [decoder decodeIntForKey:@"key"];
        self.isScene = [decoder decodeBoolForKey:@"isScene"];
        self.isEnding = [decoder decodeBoolForKey:@"isEnding"];
    }
    return self;
}

@end
