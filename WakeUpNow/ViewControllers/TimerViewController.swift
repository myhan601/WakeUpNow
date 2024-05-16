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
    
    lazy var timerStartBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("시작", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = UIColor(white: 0, alpha: 0.2)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
        return button
    }()
    
    lazy var timerCancelBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.backgroundColor = UIColor(white: 0, alpha: 0.2)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.addTarget(self, action: #selector(cancelTimer), for: .touchUpInside)
        return button
    }()
    
    lazy var countDownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 36)
        label.text = "00:00:00"
        label.backgroundColor = UIColor(white: 0, alpha: 0.1)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectTimeTapped))
        label.addGestureRecognizer(tapGestureRecognizer)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var spacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var circularTimerView: CircularTimerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        circularTimerView = CircularTimerViewController()
        circularTimerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circularTimerView)
        NSLayoutConstraint.activate([
            circularTimerView.widthAnchor.constraint(equalToConstant: 200),
            circularTimerView.heightAnchor.constraint(equalToConstant: 200),
            circularTimerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularTimerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50)
        ])
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(countDownLabel)
        view.addSubview(timerCancelBtn)
        view.addSubview(timerStartBtn)
        view.addSubview(spacer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countDownLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            spacer.topAnchor.constraint(equalTo: countDownLabel.bottomAnchor, constant: 24),
            spacer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spacer.widthAnchor.constraint(equalToConstant: 100),
            
            timerCancelBtn.topAnchor.constraint(equalTo: countDownLabel.bottomAnchor, constant: 24),
            timerCancelBtn.trailingAnchor.constraint(equalTo: spacer.leadingAnchor),
            timerCancelBtn.widthAnchor.constraint(equalToConstant: 100),
            timerCancelBtn.heightAnchor.constraint(equalToConstant: 100),
            
            timerStartBtn.topAnchor.constraint(equalTo: countDownLabel.bottomAnchor, constant: 24),
            timerStartBtn.leadingAnchor.constraint(equalTo: spacer.trailingAnchor),
            timerStartBtn.widthAnchor.constraint(equalToConstant: 100),
            timerStartBtn.heightAnchor.constraint(equalToConstant: 100)
        ])
        timerStartBtn.layer.cornerRadius = 50
        timerCancelBtn.layer.cornerRadius = 50
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    @objc func didSelectTimeTapped() {
        let timeSettingVC = TimeSettingViewController()
        timeSettingVC.delegate = self
        timeSettingVC.modalPresentationStyle = .pageSheet
        if let sheet = timeSettingVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.selectedDetentIdentifier = .medium
        }
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
            let alertController = UIAlertController(title: "알림", message: "타이머를 설정해주세요.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        if timer.isValid {
//            timer.invalidate()
            timerStartBtn.setTitle("재시작", for: .normal)
        } else {
            let totalSeconds = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
            setupTimer(with: Double(totalSeconds))
            timerStartBtn.setTitle("멈춤", for: .normal)
        }
        timerCancelBtn.isEnabled = true
        timerCancelBtn.setTitleColor(.systemBlue, for: .normal)
    }
    
    @objc func cancelTimer() {
        timer.invalidate()
        resetTimerLabel()
        selectedHours = 0
        selectedMinutes = 0
        selectedSeconds = 0
        isTimerSet = false
        timerStartBtn.setTitle("시작", for: .normal)
        timerCancelBtn.isEnabled = false
        timerCancelBtn.setTitleColor(.lightGray, for: .normal)
    }
    
    
    
    private func setupTimer(with totalSeconds: Double) {
        timer.invalidate()
        let startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            
            let elapsedTimeSeconds = Int(Date().timeIntervalSince(startTime))
            let remainSeconds = Int(totalSeconds) - elapsedTimeSeconds
            let progress = CGFloat(elapsedTimeSeconds) / CGFloat(totalSeconds)
            
            if remainSeconds <= 0 {
                timer.invalidate()
                DispatchQueue.main.async {
                    strongSelf.timerDidFinish()
                }
                return
            }
            
            let hours = remainSeconds / 3600
            let minutes = (remainSeconds % 3600) / 60
            let seconds = remainSeconds % 60
            DispatchQueue.main.async {
                strongSelf.countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                strongSelf.circularTimerView.progress = progress
            }
        }
    }
    
    private func timerDidFinish() {
        let alertController = UIAlertController(title: "타이머 종료", message: "설정한 시간이 종료되었습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.cancelTimer()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetTimerLabel() {
        countDownLabel.text = "00:00:00"
    }
}

extension TimeInterval {
    /// %02d: 빈자리를 0으로 채우고, 2자리 정수로 표현
    var time: String {
        return String(format:"%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
