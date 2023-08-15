//
//  ViewController.swift
//  HomeWork11
//
//  Created by Sergey Ruppel on 09.08.2023.
//

import UIKit

final class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var volumeProgress: UIProgressView!
    @IBOutlet private weak var volumeSlider: UISlider!
    @IBOutlet private weak var volumeTextField: UITextField!
    @IBOutlet private weak var timePicker: UIDatePicker!
    @IBOutlet private weak var setTimeLabel: UILabel!
    @IBOutlet private weak var alarmSwitch: UISwitch!
    @IBOutlet private weak var clearButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        volumeTextField.delegate = self
        setTimeLabel.layer.cornerRadius = 5
        setTimeLabel.clipsToBounds = true
    }
    
    // MARK: - 1 Block
    @IBAction private func volumeSliderChanged(_ sender: UISlider) {
        volumeProgress.progress = sender.value
        volumeTextField.text = String(format: "%.1f", sender.value)
    }
    
    @IBAction private func volumeTextFieldChanged(_ sender: UITextField) {
        if let text = sender.text, let volumeLevel = Float(text) {
            volumeSlider.value = volumeLevel
            volumeProgress.progress = volumeLevel
        } else {
            sender.text = ""
            volumeTextField.placeholder = "Enter digits"
        }
    }
    
    @IBAction private func handleTap(_ sender: UITapGestureRecognizer) {
        volumeTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ volumeTextField: UITextField) -> Bool {
        volumeTextField.resignFirstResponder()
        return true
    }
    
    // MARK: - 2 Block
    @IBAction private func setTimePressed() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        setTimeLabel.text = formatter.string(from: timePicker.date)
        alarmSwitch.isEnabled = true
        timePicker.isEnabled = false
        clearButton.isEnabled = true
    }
    
    // MARK: - 3 Block
    @IBAction private func toggleAlarm(_ sender: UISwitch) {
        setTimeLabelColor()
    }
    
    @IBAction private func clearButtonPressed() {
        alarmSwitch.setOn(false, animated: true)
        setTimeLabelColor()
        setTimeLabel.text = "00:00"
        alarmSwitch.isEnabled = false
        timePicker.isEnabled = true
        clearButton.isEnabled = false
    }
    
    private func setTimeLabelColor() {
        setTimeLabel.backgroundColor = alarmSwitch.isOn ? .orange : .lightGray
    }
}
