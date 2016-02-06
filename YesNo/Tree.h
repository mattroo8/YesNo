//
//  Tree.h
//  YesNo
//
//  Created by Matt Rooney on 13/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"
#import "Event.h"

@interface Tree : NSObject

@property (strong,nonatomic)TreeNode *root;
@property (strong,nonatomic)TreeNode *currentNode;

-(void)insertNodeWithEvent:(Event *)event;
-(Event *)getNextEventForChoice:(BOOL)choice;
-(void)setLeafNodes;
-(Event *)searchNodeForKey:(int)key;

@end
