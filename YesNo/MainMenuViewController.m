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
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[UserStateManager sharedUserStateManager]loadCharacter]){
        _continueStoryButton.hidden = NO;
    } else {
        _continueStoryButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maineMenuNewStoryButtonPressed:(id)sender {
    
    CharacterSetupViewController *csvc = [CharacterSetupViewController new];
    csvc.delegate = self;
    [self.navigationController pushViewController:csvc animated:YES];
}

- (IBAction)mainMenuContinueStoryButtonPressed:(id)sender {
    
    AdventureViewController *advc = [AdventureViewController new];
    advc.presentedFromCharacterSetup = NO;
    [self.navigationController pushViewController:advc animated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
