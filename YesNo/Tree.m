//
//  Tree.m
//  YesNo
//
//  Created by Matt Rooney on 13/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "Tree.h"

@implementation Tree

-(id)init{
    if ( self = [super init] ) {

    }
    return self;
}

-(void)insertNodeWithEvent:(Event *)event
{
    [self insertNodeWithEvent:event andNode:self.root];
}

-(void)insertNodeWithEvent:(Event *)event andNode:(TreeNode *)node
{
    if(!self.root){
        NSLog(@"MATT TEST Creating root node with event: %@",event.eventText);
        self.root = [[TreeNode alloc]initWithEvent:event];
        _currentNode = self.root;
    } else {
        
        TreeNode *current = self.root;
        while (current) {
            if(event.key < current.event.key){
                if(!current.leftChild){
                    current.leftChild = [[TreeNode alloc]initWithEvent:event];
                    return;
                } else {
                    current = current.leftChild;
                }
            } else {
                if(!current.rightChild){
                    current.rightChild = [[TreeNode alloc]initWithEvent:event];
                    return;
                } else {
                    current = current.rightChild;
                }
            }
        }
    }
}

-(Event *)getNextEventForChoice:(BOOL)choice
{
    if(!_currentNode){
        _currentNode = self.root;
        return _currentNode.event;
    } else {
        if(choice){
            if(_currentNode.rightChild){
                _currentNode = _currentNode.rightChild;
                return _currentNode.event;
            } else {
                NSLog(@"Reached end of right side of tree...");
                return nil;
            }
        } else {
            if(_currentNode.leftChild){
                _currentNode = _currentNode.leftChild;
                return _currentNode.event;
            } else {
                NSLog(@"Reached end of left side of tree...");
                return nil;
            }
        }
    }
}

-(void)setLeafNodes
{
    [self setLeafNode:self.root];
}

-(void)setLeafNode:(TreeNode *)node
{
    TreeNode *currentNode;
    if(!node){
        currentNode = self.root;
    } else {
        currentNode = node;
    }
    
    if (!currentNode.leftChild && !currentNode.rightChild) {
        NSLog(@"Setting event: %@ as leaf node",currentNode.event.eventText);
        currentNode.isLeaf = TRUE;
    } else{
        [self setLeafNode:currentNode.leftChild];
        [self setLeafNode:currentNode.rightChild];
    }
}

-(Event *)searchNodeForKey:(int)key
{
    TreeNode *node = [self searchNodeForKey:key andNode:_root];
    return node.event;
}

-(TreeNode *)searchNodeForKey:(int)key andNode:(TreeNode *)node
{
    if(node){
        if(node.event.key == key){
            _currentNode = node;
            return node;
        } else {
            TreeNode *foundNode = [self searchNodeForKey:key andNode:node.leftChild];
            if(!foundNode){
                foundNode = [self searchNodeForKey:key andNode:node.rightChild];
            }
            _currentNode = foundNode;
            return foundNode;
        }
    } else {
        return nil;
    }
}

@end
