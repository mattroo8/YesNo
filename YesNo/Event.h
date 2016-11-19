//
//  Event.h
//  YesNo
//
//  Created by Matt Rooney on 20/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject <NSCoding>

@property (nonatomic, strong) NSString *eventText;
@property (nonatomic, strong) NSString *storyName;
@property BOOL answer;
@property int key;
@property BOOL isScene;
@property BOOL isEnding;

@end
