//
//  UserStateManager.m
//  YesNo
//
//  Created by Matt Rooney on 12/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "UserStateManager.h"

@interface UserStateManager()

@property (strong,nonatomic)NSArray *paths;
@property (strong,nonatomic)NSString *documentsDirectory;
@property (strong,nonatomic)NSString *characterFileName;
@property (strong,nonatomic)NSString *sceneFileName;
@property (strong,nonatomic)NSString *characterFile;
@property (strong,nonatomic)NSString *sceneFile;

@end

@implementation UserStateManager

static UserStateManager* _sharedUserState = nil;

-(id)init {
    if ( self = [super init] ) {
        _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        _documentsDirectory = [_paths objectAtIndex:0];
        _characterFileName = @"character.txt";
        _characterFile = [_documentsDirectory stringByAppendingPathComponent:_characterFileName];
        _sceneFileName = @"scene.txt";
        _mainCharacter = [self loadCharacter];
    }
    return self;
}

+(UserStateManager*)sharedUserStateManager
{
    @synchronized([UserStateManager class])
    {
        if (!_sharedUserState){
            _sharedUserState = [[self alloc] init];
        }
        
        return _sharedUserState;
    }
    
    return nil;
}

-(void)saveCharacter:(Character *)character
{
    if(!character){
        NSLog(@"Character is nil, cannot save");
        return;
    }
    NSMutableArray *myObject=[NSMutableArray array];
    [myObject addObject:character];
    
    [NSKeyedArchiver archiveRootObject:myObject toFile:_characterFile];
}

-(Character *)loadCharacter
{
    NSMutableArray* myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_characterFile];
    return [myArray objectAtIndex:0];
}

-(void)saveProgress:(Scene *)scene
{
    _sceneFile = [_documentsDirectory stringByAppendingPathComponent:_sceneFileName];
    
    NSMutableArray *myObject=[NSMutableArray array];
    [myObject addObject:scene];
    
    [NSKeyedArchiver archiveRootObject:myObject toFile:_sceneFile];
}

-(Scene *)loadScene
{
    NSMutableArray* myArray = [NSKeyedUnarchiver unarchiveObjectWithFile:_sceneFile];
    return [myArray objectAtIndex:0];
}

@end
