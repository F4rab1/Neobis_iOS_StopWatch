//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Фараби Иса on 11.04.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer:Timer = Timer()
    var timeNumber:Int = 0
    var timerCounting:Bool = false
    
    var playPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }


    @IBAction func playPressed(_ sender: UIButton) {
        
        playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        
        timerCounting = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        
        stopButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)

        if timerCounting == true {
            timer.invalidate()
            timerCounting = false
        }
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        
        resetButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
        
        timer.invalidate()
        timerCounting = false
        timeNumber = 0
        timeLabel.text = "00:00:00"
    }
    
    @objc func timerCounter() -> Void {
        
        timeNumber += 1
        let time = secondsToHoursMinutesSeconds(seconds: timeNumber)
        //print(time)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        //print(timeString)
        timeLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += ":"
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
}

