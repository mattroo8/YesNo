//
//  MainMenuNavDelegate.h
//  YesNo
//
//  Created by Matt Rooney on 27/02/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainMenuNavDelegate <NSObject>

@optional

-(void)presentViewController:(UIViewController *)vc;

@end
