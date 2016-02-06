//
//  Scene.h
//  YesNo
//
//  Created by Matt Rooney on 10/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
#import "Event.h"

@interface Scene : NSObject <NSCoding>

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSArray *events;
@property (strong,nonatomic) Event *currentEvent;

@end
