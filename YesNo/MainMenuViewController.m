//
//  MainMenuViewController.m
//  YesNo
//
//  Created by Matt Rooney on 09/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import "MainMenuViewController.h"
#import "AdventureViewController.h"
#import "CharacterSetupViewController.h"
#import "UserStateManager.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UserStateManager *usm = [UserStateManager sharedUserStateManager];
    if(!usm.mainCharacter){
        usm.mainCharacter = [Character new];
        _continueStoryButton.hidden = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maineMenuNewStoryButtonPressed:(id)sender {
    
    [self presentViewController:[CharacterSetupViewController new] animated:YES completion:nil];
}

- (IBAction)mainMenuContinueStoryButtonPressed:(id)sender {
    
    [self presentViewController:[AdventureViewController new] animated:YES completion:nil];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



@end
