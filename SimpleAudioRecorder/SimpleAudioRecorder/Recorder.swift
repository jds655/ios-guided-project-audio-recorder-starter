//
//  Recorder.swift
//  SimpleAudioRecorder
//
//  Created by Joshua Sharp on 10/29/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import AVFoundation

protocol RecorderDelegate {
    
}

class Recorder: NSObject {
    var audioRecorder: AVAudioRecorder?
    var isRecording: Bool {
        return audioRecorder?.isRecording ?? false
    }
    
    override init() {
        
    }
    //record
    func record() {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let name = ISO8601DateFormatter.string(from: Date(), timeZone: .current, formatOptions: [.withInternetDateTime])
        let file = documentsDirectory.appendingPathComponent(name).appendingPathExtension("caf")
        let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)!
        do {
            print ("record path: \(file)")
            audioRecorder = try AVAudioRecorder(url: file, format: format)
        } catch {
            NSLog("Creating recording failed: \(error)")
        }
        audioRecorder?.record()
    }
    
    //stop
    func stop () {
        audioRecorder?.stop()
    }
    
    func toggleRecording () {
        if isRecording {
            stop()
        } else {
            record()
        }
    }
}

extension Recorder: AVAudioRecorderDelegate {
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
    }
}
