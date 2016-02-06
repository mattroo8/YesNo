//
//  SceneParser.m
//  YesNo
//
//  Created by Matt Rooney on 16/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "SceneParser.h"
#import "Event.h"

@implementation SceneParser

- (void)startParsingFile:(NSString *)fileName
{
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    _element = elementName;
    if ([_element isEqualToString:@"scene"]) {
        _events = [NSMutableArray new];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    BOOL textFound;
    NSString *emptyString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    textFound = [emptyString isEqualToString:@""] ? NO : YES;
    
    if(textFound){
        
        if([_element isEqualToString:@"event"]){
            _event = [Event new];
            _event.eventText = string;
        } else if ([_element isEqualToString:@"answer"]){
            _event.answer = string;
        } else if([_element isEqualToString:@"key"]){
            _event.key = [string intValue];
        }else if([_element isEqualToString:@"isScene"]){
            _event.isScene = [string boolValue];
        }
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([_element isEqualToString:@"isScene"]){
        
        [_events addObject:_event];
        
    }
    if([elementName isEqualToString:@"scene"]){
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:_events forKey:@"events"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"EventsReceivedNotification"
                                                           object:nil
                                                         userInfo:userInfo];
    }
    
}

@end
