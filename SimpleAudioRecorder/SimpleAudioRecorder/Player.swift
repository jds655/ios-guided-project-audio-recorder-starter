//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Joshua Sharp on 10/29/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

class Player: NSObject {
    var audioPlayer: AVAudioPlayer?
    //init
    //isPlaying
    //play
    //pause
    //playPause
    //seekToPosition: Double
    
    override init() {
        let songURL = Bundle.main.url(forResource: "piano.mpg", withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
        } catch {
            NSLog("Error opening piano.mpg: \(error)")
        }
        super.init()
    }
    
}
