//
//  TimerViewController.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/13/24.
//

import UIKit

class TimerViewController : UIViewController, TimeSettingDelegate {
    private var timer = Timer()
    private var selectedHours: Int = 0
    private var selectedMinutes: Int = 0
    private var selectedSeconds: Int = 0
    private var isTimerSet: Bool = false
    
    lazy var confirmTimerSettingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("시작", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24)
        return label
    }()
    
    lazy var timeSettingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("타이머 설정", for: .normal)
        button.addTarget(self, action: #selector(didSelectTimeStart), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(timeSettingButton)
        view.addSubview(confirmTimerSettingButton)
        view.addSubview(countDownLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countDownLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            confirmTimerSettingButton.topAnchor.constraint(equalTo: countDownLabel.bottomAnchor, constant: 24),
            confirmTimerSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timeSettingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSettingButton.topAnchor.constraint(equalTo: confirmTimerSettingButton.bottomAnchor, constant: 20)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate() // 화면이 사라질 때 타이머를 무효화합니다.
    }
    
    @objc func didSelectTimeStart() {
        let timeSettingVC = TimeSettingViewController()
        timeSettingVC.delegate = self
        present(timeSettingVC, animated: true, completion: nil)
    }
    
    func didSelectTime(hours: Int, minutes: Int, seconds: Int) {
        selectedHours = hours
        selectedMinutes = minutes
        selectedSeconds = seconds
        countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        isTimerSet = true
    }
    
    @objc func startTimer() {
        if !isTimerSet {
            // 타이머가 설정되지 않았으면 설정하도록 유도
            let alertController = UIAlertController(title: "알림", message: "타이머를 설정해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        let totalSeconds = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
        setTimer(with: Double(totalSeconds))
    }
    
    private func setTimer(with totalSeconds: Double) {
        let startTime = Date()
        timer.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            let elapsedTimeSeconds = Int(Date().timeIntervalSince(startTime))
            let remainSeconds = Int(totalSeconds) - elapsedTimeSeconds
            
            guard remainSeconds >= 0 else {
                timer.invalidate()
                return
            }
            
            let hours = remainSeconds / 3600
            let minutes = (remainSeconds % 3600) / 60
            let seconds = remainSeconds % 60
            
            DispatchQueue.main.async {
                self?.countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            }
        }
    }
}
