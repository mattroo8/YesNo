//
//  TreeNode.h
//  YesNo
//
//  Created by Matt Rooney on 13/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface TreeNode : NSObject

@property (strong,nonatomic)TreeNode *leftChild;
@property (strong,nonatomic)TreeNode *rightChild;
@property (strong,nonatomic)Event *event;
@property BOOL isLeaf;

-(id)initWithEvent:(Event *)event;

@end
