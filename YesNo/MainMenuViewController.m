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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutButtonTopToNSBottom;

@end

@implementation MainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([[UserStateManager sharedUserStateManager]loadCharacter]){
        _continueStoryButton.hidden = NO;
        _aboutButtonTopToNSBottom.constant = 90;
    } else {
        _continueStoryButton.hidden = YES;
        _aboutButtonTopToNSBottom.constant = 45;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)maineMenuNewStoryButtonPressed:(id)sender {
    
    Character *mainCharacter = [Character new];
    mainCharacter.firstName = @"firstName";
    mainCharacter.lastName = @"lastName";
    mainCharacter.age = @"age";
    mainCharacter.sex = @"sex";
    mainCharacter.currentStory = @"intro";
    mainCharacter.eventHistory = [NSMutableArray new];
    mainCharacter.currentEvent = nil;
    mainCharacter.currentEventIndex = 0;
    
    [[UserStateManager sharedUserStateManager] saveCharacter:mainCharacter];
    AdventureViewController *advc = [AdventureViewController new];
    advc.isInAboutMode = NO;
    [self.navigationController pushViewController:advc animated:YES];
}

- (IBAction)mainMenuContinueStoryButtonPressed:(id)sender {
    
    AdventureViewController *advc = [AdventureViewController new];
    advc.isInAboutMode = NO;
    [self.navigationController pushViewController:advc animated:YES];
}
- (IBAction)aboutButtonPressed:(id)sender {
    AdventureViewController *advc = [AdventureViewController new];
    advc.isInAboutMode = YES;
    [self.navigationController pushViewController:advc animated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
