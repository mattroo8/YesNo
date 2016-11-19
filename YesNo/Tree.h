//
//  Tree.h
//  YesNo
//
//  Created by Matt Rooney on 13/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreeNode.h"

@interface Tree : NSObject

@property (strong,nonatomic)TreeNode *root;
@property (strong,nonatomic)TreeNode *currentNode;

-(void)insertNodeWithEvent:(Event *)event;
-(Event *)getNextEventForChoice:(DecisionEnum)choice;
-(void)setLeafNodes;
-(Event *)searchNodeForKey:(int)key;

@end
