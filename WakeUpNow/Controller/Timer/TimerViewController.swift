//
//  TimerViewController.swift
//  WakeUpNow
//
//  Created by 서혜림 on 5/13/24.
//

import UIKit
import AVFoundation

class TimerViewController: UIViewController, TimeSettingDelegate, SoundSettingDelegate {
    
    // MARK: - Properties
    private var timer = Timer()
    private var selectedHours: Int = 0
    private var selectedMinutes: Int = 0
    private var selectedSeconds: Int = 0
    private var isTimerSet: Bool = false
    private var isTimerRunning: Bool = false
    private var remainingTimeInSeconds: Int = 0
    private var startTime: Date?
    private var endTime: Date?
    private var alarmPlayer: AVAudioPlayer?
    private var selectedSound: String = "Alarm.mp3"
    
    // UI Components
    lazy var timerStartBtn: UIButton = mainBtn(title: "시작", action: #selector(startTimer))
    lazy var timerCancelBtn: UIButton = mainBtn(title: "취소", action: #selector(cancelTimer), isEnabled: false)
    lazy var countDownLabel: UILabel = timeLabel(text: "00:00")
    lazy var endTimeLabel: UILabel = subLabel(text: "탭하여 설정")
    
    // 사운드 설정 버튼
    lazy var soundSettingBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = ColorPalette.wakeBeige
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        let titleLabel = UILabel()
        titleLabel.text = "알람 사운드"
        titleLabel.textColor = ColorPalette.wakeDeepNavy
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(titleLabel)
        
        let soundNameLabel = UILabel()
        soundNameLabel.text = selectedSound
        soundNameLabel.textColor = ColorPalette.wakeDeepNavy
        soundNameLabel.font = .systemFont(ofSize: 18)
        soundNameLabel.translatesAutoresizingMaskIntoConstraints = false
        soundNameLabel.textAlignment = .left
        button.addSubview(soundNameLabel)
        self.soundNameLabel = soundNameLabel
        
        let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImageView.tintColor = ColorPalette.wakeDeepNavy
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            soundNameLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            soundNameLabel.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -30),
            
            arrowImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -10),
            arrowImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        button.addTarget(self, action: #selector(soundSettingTapped), for: .touchUpInside)
        
        return button
    }()

    
    lazy var soundNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.wakeDeepNavy
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private var circularTimerView: CircularTimerView = {
        let view = CircularTimerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.wakeLightBeige
//        timerStartBtn.setTitleColor(.ColorPalette.wakeLightBeige, for: .normal)
        timerStartBtn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        setupSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isTimerRunning {
            setupTimer(with: Double(remainingTimeInSeconds))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isTimerRunning {
            timer.invalidate()
        }
    }
    
    // MARK: - Methods
    private func setupSubviews() {
        view.addSubview(countDownLabel)
        view.addSubview(timerCancelBtn)
        view.addSubview(timerStartBtn)
        view.addSubview(circularTimerView)
        view.addSubview(soundSettingBtn)
        view.addSubview(endTimeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            circularTimerView.widthAnchor.constraint(equalToConstant: 300),
            circularTimerView.heightAnchor.constraint(equalToConstant: 300),
            circularTimerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circularTimerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150),
            
            endTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endTimeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -190),
            
            countDownLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            countDownLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            
            timerCancelBtn.topAnchor.constraint(equalTo: circularTimerView.bottomAnchor, constant: 20),
            timerCancelBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timerCancelBtn.widthAnchor.constraint(equalToConstant: 100),
            timerCancelBtn.heightAnchor.constraint(equalToConstant: 100),
            
            timerStartBtn.topAnchor.constraint(equalTo: circularTimerView.bottomAnchor, constant: 20),
            timerStartBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timerStartBtn.widthAnchor.constraint(equalToConstant: 100),
            timerStartBtn.heightAnchor.constraint(equalToConstant: 100),
            
            soundSettingBtn.topAnchor.constraint(equalTo: timerStartBtn.bottomAnchor, constant: 20),
            soundSettingBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            soundSettingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            soundSettingBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        timerStartBtn.layer.cornerRadius = 50
        timerCancelBtn.layer.cornerRadius = 50
        view.bringSubviewToFront(countDownLabel)
    }
    
    private func mainBtn(title: String, action: Selector, isEnabled: Bool = true) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.backgroundColor = isEnabled ? ColorPalette.wakeBeige : ColorPalette.wakeLightGray
        button.setTitleColor(isEnabled ? ColorPalette.wakeDeepNavy : .gray, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.isEnabled = isEnabled
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func subBtn(title: String, action: Selector, isEnabled: Bool = true) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.backgroundColor = ColorPalette.wakeBeige
        button.setTitleColor(isEnabled ? ColorPalette.wakeDeepNavy : .lightGray, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.isEnabled = isEnabled
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func timeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorPalette.wakeGray
        label.font = .systemFont(ofSize: 65)
        label.text = text
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectTimeTapped))
        label.addGestureRecognizer(tapGestureRecognizer)
        label.isUserInteractionEnabled = true
        return label
    }
    
    private func subLabel(text: String) -> UILabel {
        let label = UILabel()
        label.textColor = ColorPalette.wakeGray
        label.font = .systemFont(ofSize: 20)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        remainingTimeInSeconds = selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds
        countDownLabel.textColor = ColorPalette.wakeDeepNavy
        updateTimerLabel()
        isTimerSet = true
    }
    
    @objc func startTimer() {
        guard isTimerSet else {
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
            calculateEndTime()
            timerStartBtn.setTitle("일시정지", for: .normal)
            isTimerRunning = true
        }
        timerCancelBtn.isEnabled = true
        timerCancelBtn.setTitleColor(ColorPalette.wakeRed, for: .normal)
    }
    
    @objc func cancelTimer() {
        timer.invalidate()
        resetTimerLabel()
        selectedHours = 0
        selectedMinutes = 0
        selectedSeconds = 0
        remainingTimeInSeconds = 0
        isTimerSet = false
        isTimerRunning = false
        timerStartBtn.setTitle("시작", for: .normal)
        timerCancelBtn.isEnabled = false
        timerCancelBtn.setTitleColor(.lightGray, for: .normal)
        
        circularTimerView.resetProgress()
        endTimeLabel.text = "탭하여 설정"
    }
    
    private func setupTimer(with totalSeconds: Double) {
        remainingTimeInSeconds = Int(totalSeconds)
        timer.invalidate()
        startTime = Date()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            self.remainingTimeInSeconds -= 1
            
            if self.remainingTimeInSeconds <= 0 {
                self.timer.invalidate()
                DispatchQueue.main.async {
                    self.timerDidFinish()
                }
                return
            }
            DispatchQueue.main.async {
                self.updateTimerLabel()
            }
        }
    }
    
    private func updateTimerLabel() {
        let hours = remainingTimeInSeconds / 3600
        let minutes = (remainingTimeInSeconds % 3600) / 60
        let seconds = remainingTimeInSeconds % 60
        
        if hours > 0 {
            countDownLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            countDownLabel.text = String(format: "%02d:%02d", minutes, seconds)
        }
        
        let totalSeconds = Double(selectedHours * 3600 + selectedMinutes * 60 + selectedSeconds)
        circularTimerView.updateProgress(CGFloat(remainingTimeInSeconds) / CGFloat(totalSeconds))
    }
    
    private func timerDidFinish() {
        playAlarmSound()
        
        let alertController = UIAlertController(title: "타이머 종료", message: "설정한 시간이 종료되었습니다.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.cancelTimer()
        })
        present(alertController, animated: true, completion: nil)
    }
    
    private func resetTimerLabel() {
        countDownLabel.text = "00:00"
        circularTimerView.resetProgress()
    }
    
    private func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: selectedSound, withExtension: "mp3", subdirectory: "Ringtones") else {
            print("사운드 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            alarmPlayer = try AVAudioPlayer(contentsOf: soundURL)
            alarmPlayer?.prepareToPlay()
            alarmPlayer?.play()
        } catch {
            print("사운드 파일을 재생할 수 없습니다: \(error.localizedDescription)")
        }
    }
    
    private func calculateEndTime() {
        guard isTimerSet else { return }
        endTime = Calendar.current.date(byAdding: .second, value: remainingTimeInSeconds, to: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        if let endTime = endTime {
            endTimeLabel.text = "종료 " + formatter.string(from: endTime)
        }
    }
    
    @objc func soundSettingTapped() {
        let soundSettingVC = SoundSettingViewController()
        soundSettingVC.delegate = self
        soundSettingVC.modalPresentationStyle = .pageSheet
        if let sheet = soundSettingVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.selectedDetentIdentifier = .medium
        }
        present(soundSettingVC, animated: true, completion: nil)
    }
    
    func setAlarmSound(named soundName: String) {
        self.selectedSound = soundName
        soundNameLabel.text = soundName
    }
}

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(self) * .pi / 180
    }
}
