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
    private var isTimerRunning: Bool = false
    private var remainingTimeInSeconds: Int = 0
    private var startTime: Date?
    
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
    
    private var circularTimerView: CircularTimerViewController! = {
        let view = CircularTimerViewController()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(countDownLabel)
        view.addSubview(timerCancelBtn)
        view.addSubview(timerStartBtn)
        view.addSubview(spacer)
        view.addSubview(circularTimerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            circularTimerView.widthAnchor.constraint(equalToConstant: 300),
            circularTimerView.heightAnchor.constraint(equalToConstant: 300),
            circularTimerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularTimerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            spacer.topAnchor.constraint(equalTo: circularTimerView.bottomAnchor, constant: 24),
            spacer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spacer.widthAnchor.constraint(equalToConstant: 100),
            
            timerCancelBtn.topAnchor.constraint(equalTo: circularTimerView.bottomAnchor, constant: 24),
            timerCancelBtn.trailingAnchor.constraint(equalTo: spacer.leadingAnchor),
            timerCancelBtn.widthAnchor.constraint(equalToConstant: 100),
            timerCancelBtn.heightAnchor.constraint(equalToConstant: 100),
            
            timerStartBtn.topAnchor.constraint(equalTo: circularTimerView.bottomAnchor, constant: 24),
            timerStartBtn.leadingAnchor.constraint(equalTo: spacer.trailingAnchor),
            timerStartBtn.widthAnchor.constraint(equalToConstant: 100),
            timerStartBtn.heightAnchor.constraint(equalToConstant: 100)
        ])
        timerStartBtn.layer.cornerRadius = 50
        timerCancelBtn.layer.cornerRadius = 50
        view.bringSubviewToFront(countDownLabel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isTimerRunning {
            timer.invalidate()
        }
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

        if isTimerRunning {
            timer.invalidate()
            isTimerRunning = false
            timerStartBtn.setTitle("재개", for: .normal)
        } else {
            if remainingTimeInSeconds <= 0 {
                remainingTimeInSeconds = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
            }
            setupTimer(with: Double(remainingTimeInSeconds))
            timerStartBtn.setTitle("일시정지", for: .normal)
            isTimerRunning = true
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
        
        circularTimerView.resetProgress()
    }
    
    private func setupTimer(with totalSeconds: Double) {
        remainingTimeInSeconds = Int(totalSeconds)
        timer.invalidate()
        startTime = Date()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let strongSelf = self else { return }

            strongSelf.remainingTimeInSeconds -= 1

            if strongSelf.remainingTimeInSeconds <= 0 {
                strongSelf.timer.invalidate()
                DispatchQueue.main.async {
                    strongSelf.timerDidFinish()
                }
                return
            }

            DispatchQueue.main.async {
                strongSelf.updateTimerLabel()
            }
        }
    }

    private func updateTimerLabel() {
        let hours = remainingTimeInSeconds / 3600
        let minutes = (remainingTimeInSeconds % 3600) / 60
        let seconds = remainingTimeInSeconds % 60
        countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        let totalSeconds = Double(selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds)
        circularTimerView.updateProgress(CGFloat(remainingTimeInSeconds) / CGFloat(totalSeconds))
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
    var time: String {
        return String(format:"%02d:%02d", Int(self/60), Int(ceil(truncatingRemainder(dividingBy: 60))) )
    }
}

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
