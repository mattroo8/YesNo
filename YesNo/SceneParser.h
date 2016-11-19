//
//  SceneParser.h
//  YesNo
//
//  Created by Matt Rooney on 16/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface SceneParser : NSObject <NSXMLParserDelegate>

@property (nonatomic, strong) NSString *element;
@property (nonatomic, strong) Event *event;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSString *storyName;

- (void)startParsingFile:(NSString *)fileName;

@end
