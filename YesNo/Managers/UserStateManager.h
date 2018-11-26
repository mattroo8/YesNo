//
//  UserStateManager.h
//  YesNo
//
//  Created by Matt Rooney on 12/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "Scene.h"

@interface UserStateManager : NSObject

-(void)saveCharacter:(Character *)character;
-(Character *)loadCharacter;
-(void)saveProgress:(Scene *)scene;
+(UserStateManager*)sharedUserStateManager;
-(void)deleteProgress;

@end
