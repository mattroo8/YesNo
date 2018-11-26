//
//  Event.h
//  YesNo
//
//  Created by Matt Rooney on 20/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecisionEnum.h"

@interface Event : NSObject <NSCoding>

@property (nonatomic, strong) NSString *eventText;
@property (nonatomic, strong) NSString *storyName;
@property int key;
@property BOOL isScene;
@property BOOL isEnding;
@property DecisionEnum decision;

@end
