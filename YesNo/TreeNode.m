//
//  TreeNode.m
//  YesNo
//
//  Created by Matt Rooney on 13/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode

-(id)initWithEvent:(Event *)event {
    if ( self = [super init] ) {
        _event = event;
        _leftChild = nil;
        _rightChild = nil;
    }
    return self;
}

@end
