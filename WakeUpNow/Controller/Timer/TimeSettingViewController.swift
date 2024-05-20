//
// TimeSettingViewController.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/14/24.
//

import UIKit

protocol TimeSettingDelegate: AnyObject {
    func didSelectTime(hours: Int, minutes: Int, seconds: Int)
}

class TimeSettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    weak var delegate: TimeSettingDelegate?
    
    let hours = Array(0...23)
    let minutes = Array(0...59)
    let seconds = Array(0...59)
    
    lazy var timePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인", for: .normal)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Methods
    private func setupSubviews() {
        view.addSubview(timePicker)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            confirmButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func confirmButtonTapped() {
        let selectedHours = hours[timePicker.selectedRow(inComponent: 0)]
        let selectedMinutes = minutes[timePicker.selectedRow(inComponent: 1)]
        let selectedSeconds = seconds[timePicker.selectedRow(inComponent: 2)]
        
        delegate?.didSelectTime(hours: selectedHours, minutes: selectedMinutes, seconds: selectedSeconds)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIPickerViewDataSource
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
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hours[row])시간"
        case 1:
            return "\(minutes[row])분"
        case 2:
            return "\(seconds[row])초"
        default:
            return nil
        }
    }
}
