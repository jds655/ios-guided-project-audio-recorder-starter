//
//  ViewController.swift
//  AudioRecorder
//
//  Created by Paul Solt on 10/1/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

import UIKit

class AudioRecorderController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var timeSlider: UISlider!
	
    private var player: Player
    private var recorder: Recorder
	private lazy var timeFormatter: DateComponentsFormatter = {
		let formatting = DateComponentsFormatter()
		formatting.unitsStyle = .positional // 00:00  mm:ss
		// NOTE: DateComponentFormatter is good for minutes/hours/seconds
		// DateComponentsFormatter not good for milliseconds, use DateFormatter instead)
		formatting.zeroFormattingBehavior = .pad
		formatting.allowedUnits = [.minute, .second]
		return formatting
	}()
	
    required init?(coder aDecoder: NSCoder) {
        player = Player()
        recorder = Recorder()
        print ("At init(coder")
        super.init(coder: aDecoder)
        player.delegate = self
        recorder.delegate = self
        
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()


        timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize,
                                                          weight: .regular)
        timeRemainingLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeRemainingLabel.font.pointSize,
                                                                   weight: .regular)
	}


    @IBAction func playButtonPressed(_ sender: Any) {
        player.playPause()
	}
    
    @IBAction func recordButtonPressed(_ sender: Any) {
        recorder.toggleRecording()
    }
    
    private func updateViews() {
        let playTitle = player.isPlaying ? "Pause" : "Play"
        playButton.setTitle(playTitle, for: .normal)
        
        let recordTitle = recorder.isRecording ? "Stop Recording" : "Record"
        recordButton.setTitle(recordTitle, for: .normal)
    }
}

extension AudioRecorderController: PlayerDelegate {
    func playDidChangeState(player: Player) {
        //update the UI
        updateViews()
    }
}
extension AudioRecorderController: RecorderDelegate {
    func recorderDidChangeState(recorder: Recorder) {
        updateViews()
    }
    
    func recorderDidSaveFile(recorder: Recorder) {
        updateViews()
        //TODO: - Play the file
        if let url = recorder.fileURL, recorder.isRecording == false {
            //Play the recording
            player = Player(url: url)
            player.delegate = self
        }
    }
    
    
}
