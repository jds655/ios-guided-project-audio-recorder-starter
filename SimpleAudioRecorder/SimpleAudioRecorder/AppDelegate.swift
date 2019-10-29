//
//  AppDelegate.swift
//  SimpleAudioRecorder
//
//  Created by Paul Solt on 10/1/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        requestMicrophonePermission()
        
        return true
    }
    
    func requestMicrophonePermission() {
        let session = AVAudioSession.sharedInstance()
        session.requestRecordPermission { granted in
            guard granted == true else {
                //TODO: - Present this to the User
                print("We need microphone access")
                return
            }
            
            do {
                try session.setCategory(.playAndRecord, mode: .default, options: [])
                try session.overrideOutputAudioPort(.speaker)
                try session.setActive(true, options: [])
            } catch {
                NSLog("Error setting up audio session: \(error)")
            }
        }
    }
}

