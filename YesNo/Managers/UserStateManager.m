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

-(void)saveCharacter:(StoryCharacter *)character
{
    if(!character){
        return;
    }
    NSMutableArray *myObject=[NSMutableArray array];
    [myObject addObject:character];
    
    [NSKeyedArchiver archiveRootObject:myObject toFile:_characterFile];
}

-(StoryCharacter *)loadCharacter
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

-(void)deleteProgress
{
    NSError *error;
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:_characterFile]) {
        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:_characterFile error:&error];
        if (!success) {
            NSLog(@"Error removing file at path: %@", error.localizedDescription);
        }
    }
}

@end
