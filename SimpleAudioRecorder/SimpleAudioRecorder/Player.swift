//
//  Player.swift
//  SimpleAudioRecorder
//
//  Created by Joshua Sharp on 10/29/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

protocol PlayerDelegate {
    func playDidChangeState(player: Player)
}

class Player: NSObject {
    var delegate: PlayerDelegate?
    var audioPlayer: AVAudioPlayer?
    var isPlaying: Bool {
        return audioPlayer?.isPlaying ?? false
    }
    
    //init
    
    override init() {
        let songURL = Bundle.main.url(forResource: "piano", withExtension: "mp3")!
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: songURL)
        } catch {
            NSLog("Error opening piano.mp3: \(error)")
        }
        super.init()
        audioPlayer?.delegate = self
    }
    
    
    //play
    func play() {
        audioPlayer?.play()
        delegate?.playDidChangeState(player: self)
    }
    
    //pause
    func pause () {
        audioPlayer?.pause()
        delegate?.playDidChangeState(player: self)
    }
    
    //playPause
    func playPause () {
        if isPlaying {
            self.pause()
        } else {
            self.play()
        }
    }
    
    //seekToPosition: Double
    
}

extension Player: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        NSLog("AVAudio Error: \(String(describing: error))")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.playDidChangeState(player: self)
    }
}
