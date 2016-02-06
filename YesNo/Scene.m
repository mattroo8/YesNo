//
//  Scene.m
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "Scene.h"

@implementation Scene

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.events forKey:@"events"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.currentEvent forKey:@"currentEvent"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.events = [decoder decodeObjectForKey:@"events"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.currentEvent = [decoder decodeObjectForKey:@"currentEvent"];
    }
    return self;
}

@end
