//
//  MainMenuViewController.h
//  YesNo
//
//  Created by Matt Rooney on 09/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuNavDelegate.h"

@interface MainMenuViewController : UIViewController <MainMenuNavDelegate>

@property (weak, nonatomic) IBOutlet UIButton *beginStoryButton;
@property (weak, nonatomic) IBOutlet UIButton *continueStoryButton;

@property (strong, nonatomic) UINavigationController *navController;

@end

