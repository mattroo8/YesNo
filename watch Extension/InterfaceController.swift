//
//  InterfaceController.swift
//  watch Extension
//
//  Created by Rooney, Matthew (IE - Dublin) on 26/11/2018.
//  Copyright © 2018 Matt Rooney. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var textLabel: WKInterfaceLabel!
    @IBOutlet var YesButton: WKInterfaceButton!
    @IBOutlet var NoButton: WKInterfaceButton!
    @IBOutlet var restartButton: WKInterfaceButton!
    
    private var session = WCSession.default
    
    private let storyManager: StoryManager = {
        let storyManager = StoryManager()
        return storyManager!
    }()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        restartButton.setHidden(true)
        YesButton.setHidden(true)
        NoButton.setHidden(true)
        if isSuported() {
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func isSuported() -> Bool {
        return WCSession.isSupported()
    }
    
    private func isReachable() -> Bool {
        return session.isReachable
    }

    @IBAction func yesPressed() {
        storyManager.getNextText(forChoice: DecisionEnum(rawValue: 1))
    }
    
    @IBAction func noPressed() {
        storyManager.getNextText(forChoice: DecisionEnum(rawValue: 2))
    }
    
    @IBAction func restartPressed() {
        textLabel.setText(nil)
        restartButton.setHidden(true)
        let character = createMainCharacter()
        setUpStory(for: character)
    }
    
    func createMainCharacter() -> StoryCharacter {
        let character = StoryCharacter()
        character.firstName = "firstName"
        character.firstName = "lastName"
        character.currentStory = "intro"
        character.eventHistory = []
        character.currentEvent = nil
        character.currentEventIndex = 0
        return character
    }
    
    func setUpStory(for character: StoryCharacter) {
        storyManager.delegate = self
        storyManager.setupStory(character)
    }
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if error != nil {
            print("Failed tp activate session")
            return
        }
        if isReachable() {
            session.sendMessage(["request" : "version"], replyHandler: { (response) in
                print(response)
                let character = self.createMainCharacter()
                self.setUpStory(for: character)
                
            }, errorHandler: { (error) in
                print("Error sending message: %@", error)
            })
        } else {
            print("iPhone is not reachable!!")
        }
    }
    
}

extension InterfaceController: StoryManagerDelegate {
    func showYesButton(forStoryView yesButton: Bool, andNoButton noButton: Bool, andBackButton backButton: Bool, andForwardButton forwardButton: Bool) {
        YesButton.setHidden(!yesButton)
        NoButton.setHidden(!noButton)
        if !yesButton && !noButton {
            restartButton.setHidden(false)
        }
    }
    
    func setTextForStoryView(_ text: String!) {
        scroll(to: textLabel, at: .top, animated: false)
        textLabel.setText(text)
    }
    
    
}
