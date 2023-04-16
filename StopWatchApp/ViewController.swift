//
//  ViewController.swift
//  StopWatchApp
//
//  Created by Фараби Иса on 11.04.2023.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerOfTime: UIPickerView!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer:Timer = Timer()
    var timeNumber:Int = 0
    var timerCounting:Bool = false
    
    var playPressed = false
    var stopwatchSelected = false
    
    var hours = Array(0...23)
    var minutes = Array(0...59)
    var seconds = Array(0...59)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerOfTime.isHidden = true
        pickerOfTime.delegate = self
        pickerOfTime.dataSource = self
    }

    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 1 {
            pickerOfTime.isHidden = false
            stopwatchSelected = true
        } else {
            pickerOfTime.isHidden = true
            stopwatchSelected = false
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return seconds.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(format: "%02d", hours[row])
        case 1:
            return String(format: "%02d", minutes[row])
        case 2:
            return String(format: "%02d", seconds[row])
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedHours = hours[pickerView.selectedRow(inComponent: 0)]
        let selectedMinutes = minutes[pickerView.selectedRow(inComponent: 1)]
        let selectedSeconds = seconds[pickerView.selectedRow(inComponent: 2)]
        timeNumber = (selectedHours * 3600) + (selectedMinutes * 60) + selectedSeconds
        let timeString = makeTimeString(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        timeLabel.text = timeString
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        if timerCounting == false {
            timerCounting = true
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        if timerCounting == true {
            timer.invalidate()
            timerCounting = false
        }
    }
    
    @IBAction func resetPressed(_ sender: UIButton) {
        timer.invalidate()
        timerCounting = false
        timeNumber = 0
        timeLabel.text = "00:00:00"
    }
    
    @objc func timerCounter() -> Void {
        if stopwatchSelected == false {
            timeNumber += 1
        } else if stopwatchSelected == true {
            if timeNumber > 0 {
                timeNumber -= 1
            } else {
                timer.invalidate()
                timerCounting = false
            }
        }
        
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

