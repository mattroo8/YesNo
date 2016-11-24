//
//  YesNoUITests.m
//  YesNoUITests
//
//  Created by Matt Rooney on 09/01/2016.
//  Copyright © 2016 Matt Rooney. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface YesNoUITests : XCTestCase

@end

@implementation YesNoUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [XCUIDevice sharedDevice].orientation = UIDeviceOrientationPortrait;
    
    XCUIApplication *app = [[XCUIApplication alloc]init];
    [app.buttons[@"New Story"] tap];
    
    XCUIElement *textField = [[app.scrollViews.otherElements childrenMatchingType:XCUIElementTypeTextField] elementBoundByIndex:0];
    [textField tap];
    
    XCUIApplication *app2 = app;
    [app2.keys[@"m"] tap];
    [app2.keys[@"a"] tap];
    [app2.keys[@"t"] tap];
    [app2.keys[@"t"] tap];
}

@end
