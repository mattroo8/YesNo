//
//  StoryManagerDelegate.h
//  YesNo
//
//  Created by Matt Rooney on 08/02/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

@protocol StoryManagerDelegate

-(void)showYesButtonForStoryView:(BOOL)yesButton andNoButton:(BOOL)noButton andBackButton:(BOOL)backButton andForwardButton:(BOOL)forwardButton;
-(void)setTextForStoryView:(NSString *)text;

@end