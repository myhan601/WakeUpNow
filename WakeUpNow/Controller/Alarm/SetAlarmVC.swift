//
//  SetAlarmVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit
import UserNotifications

class SetAlarmVC: UIViewController, SetDayVCDelegate {
    // MARK: - variable
    
    var alarm: Alarm?
    var onSave: ((Alarm) -> Void)?
    var alarms = [Alarm]()
    var selectedDays = [String]()
    var isMissionEnabled = false
    var isReminderEnabled = false
    
    let amPm = ["오전", "오후"]
    let hours: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let minutes: [String] = [
        "00", "01", "02", "03", "04", "05", "06", "07", "08", "09",
        "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
        "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
        "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
        "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
        "50", "51", "52", "53", "54", "55", "56", "57", "58", "59",
    ]
    
    let pickerView = UIPickerView()
    let label = UILabel()
    let numberLabel = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // 제스처가 테이블뷰 셀 선택에 영향을 주지 않도록 설정
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        configureNavigationBar()
        setupDayButton()
        setupSoundSettingButton()
        setupPickerView()
        setupTableView()
        setInitialPickerViewTime()
    }
    
    // MARK: - func
    private func configureNavigationBar() {
        self.title = "알람 추가"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        // 네비게이션바 배경과 구분선을 투명하게 만듭니다.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupLabels() {
        // label 설정
        label.text = "선택된 시간대"
        label.textAlignment = .center
        view.addSubview(label)
        
        // numberLabel 설정
        numberLabel.text = "선택된 숫자"
        numberLabel.textAlignment = .center
        view.addSubview(numberLabel)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-20)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
    
    func setupPickerView() {
        // pickerView 설정
        view.addSubview(pickerView)
        
        // pickerView의 delegate와 dataSource 설정
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // SnapKit을 사용하여 pickerView의 위치와 크기를 설정
        pickerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview() // 중앙 정렬
            make.top.equalToSuperview().offset(100) // 상단으로부터 100의 거리에 위치
            make.width.equalToSuperview().multipliedBy(0.8) // 화면 너비의 80%
            make.height.equalTo(200) // 높이는 200으로 설정
        }
    }
    
    func setupTableView() {
        // tableView 설정
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 0.7
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        // SnapKit을 사용하여 tableView의 위치와 크기를 설정
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pickerView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(225)
        }
    }
    
    func setupDayButton() {
        let nextButton = UIButton(type: .system)
        nextButton.setTitle("반복요일", for: .normal)
        nextButton.addTarget(self, action: #selector(repDayButtonTapped), for: .touchUpInside)
        view.addSubview(nextButton)
        
        // SnapKit을 사용한 제약 설정
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setupSoundSettingButton() {
        let soundSettingButton = UIButton(type: .system)
        soundSettingButton.setTitle("소리 설정", for: .normal)
        soundSettingButton.addTarget(self, action: #selector(soundSettingButtonTapped), for: .touchUpInside)
        view.addSubview(soundSettingButton)
        
        // SnapKit을 사용한 제약 설정
        soundSettingButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setInitialPickerViewTime() {
        // 현재 시간을 가져옵니다.
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)
        
        // pickerView의 시간 및 분 구성 요소의 초기 선택된 행을 설정합니다.
        if let hour = components.hour, let minute = components.minute {
            // 시간을 12시간 형식으로 변환하여 pickerView의 시간 컴포넌트 초기 선택 행을 설정
            let displayHour = hour % 12 == 0 ? 12 : hour % 12 // 0시를 12시로 표시
            pickerView.selectRow(displayHour - 1, inComponent: 1, animated: false) // displayHour - 1: 인덱스가 0부터 시작하기 때문에 조정
            
            // 분을 1분 단위로 설정: 분에 해당하는 컴포넌트의 정확한 행을 선택
            pickerView.selectRow(minute, inComponent: 2, animated: false) // 분을 직접 사용하여 해당하는 행 선택
            
            // AM/PM 설정
            let selectedAmPmIndex = hour < 12 ? 0 : 1
            pickerView.selectRow(selectedAmPmIndex, inComponent: 0, animated: false)
            
            // 레이블 업데이트
            label.text = amPm[selectedAmPmIndex]
            numberLabel.text = String(format: "%02d", displayHour)
        }
    }
    
    func didSelectDays(_ selectedDays: [String]) {
        self.selectedDays = selectedDays
        tableView.reloadData()
    }
    
    // 사용자가 입력한 메모를 가져오는 함수
    func getMemoText() -> String {
        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 1)) {
            if let textField = cell.viewWithTag(100) as? UITextField {
                // textField.text가 빈 문자열인 경우도 처리하도록 수정
                return textField.text?.isEmpty == false ? textField.text! : "알람"
            }
        }
        return "알람" // 아무것도 입력하지 않았을 경우
    }
    
    // MARK: - @objc func
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func repDayButtonTapped() {
        let nextVC = SetDayVC()
        nextVC.selectedDays = selectedDays
        nextVC.delegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func soundSettingButtonTapped() {
        let nextVC = SetSoundVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func missionSwitchValueChanged(_ sender: UISwitch) {
        isMissionEnabled = sender.isOn
        print(isMissionEnabled)
    }
    
    @objc func reminderSwitchValueChanged(_ sender: UISwitch) {
        isReminderEnabled = sender.isOn
        print(isReminderEnabled)
    }
    
    @objc func saveButtonTapped() {
        // 현재 시간을 가져옵니다.
        let currentDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: currentDate)

        // pickerView에서 선택한 시간 정보를 가져옵니다.
        let selectedAmPmIndex = pickerView.selectedRow(inComponent: 0)
        let selectedHourIndex = pickerView.selectedRow(inComponent: 1)
        let selectedMinuteIndex = pickerView.selectedRow(inComponent: 2)

        // 시간과 분을 문자열에서 정수로 변환합니다.
        let amPm = self.amPm[selectedAmPmIndex]
        let hourComponent = selectedHourIndex % hours.count
        let minuteComponent = selectedMinuteIndex % minutes.count

        // 24시간제로 변환하여 현재 시간과 비교합니다.
        var hour = Int(hours[hourComponent]) ?? 0
        if amPm == "오후" && hour != 12 {
            hour += 12
        } else if amPm == "오전" && hour == 12 {
            hour = 0
        }
        let minute = Int(minutes[minuteComponent]) ?? 0

        // 선택한 시간과 현재 시간을 비교하여 알림을 띄울지 결정합니다.
        if let selectedHour = components.hour, let selectedMinute = components.minute {
            if hour == selectedHour && minute == selectedMinute {
                // 현재 시간과 선택한 시간이 동일한 경우 알림을 띄웁니다.
                let alert = UIAlertController(title: "알림", message: "현재 시간과 동일한 시간으로 알람을 설정할 수 없습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }

        // 12시간제로 변환하여 알람 저장
        var alarmHour = hour
        let alarmAmPm: String
        if hour >= 12 {
            alarmAmPm = "오후"
            if hour > 12 {
                alarmHour -= 12
            }
        } else {
            alarmAmPm = "오전"
            if hour == 0 {
                alarmHour = 12
            }
        }

        // 알람을 저장하는 로직
        let alarm = Alarm(
            isMissionEnabled: isMissionEnabled,
            amPm: alarmAmPm,
            hour: alarmHour,
            minute: minute,
            selectedDays: selectedDays,
            memo: getMemoText(),
            isReminderEnabled: isReminderEnabled,
            isAlarmOn: true
        )

        // 클로저 호출하여 알람 전달
        onSave?(alarm)

        // 알람 데이터 확인
        print(alarm)

        // 로컬 알림 스케줄링
        let content = UNMutableNotificationContent()
        content.title = "알람"
        content.body = "일어날 시간입니다!"
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("알림 스케줄링 중 오류 발생: \(error)")
            }
        }

        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDataSource
extension SetAlarmVC: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let infiniteRows = 10000 // 순환을 위한 충분히 큰 값
        if component == 0 {
            return amPm.count
        } else {
            // 시간과 분을 위한 순환 행의 수
            return infiniteRows
        }
    }
    
    // pickerView에서 보여주고 싶은 아이템의 제목
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return amPm[row]
        } else if component == 1 {
            // 시간 순환
            let actualHour = hours[row % hours.count] // modulo 연산으로 순환 효과 구현
            return actualHour
        } else {
            // 분 순환
            let actualMinute = minutes[row % minutes.count] // modulo 연산으로 순환 효과 구현
            return actualMinute
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
}

// MARK: - UIPickerViewDelegate
extension SetAlarmVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            label.text = amPm[row]
        } else if component == 1 {
            // 시간 선택 시
            let actualHour = hours[row % hours.count] // modulo 연산으로 실제 시간 계산
            numberLabel.text = actualHour
        } else {
            // 분 선택 시
            let actualMinute = minutes[row % minutes.count] // modulo 연산으로 실제 분 계산
            numberLabel.text = actualMinute
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SetAlarmVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // 섹션을 두 개로 나눔: '미션여부'와 나머지 셀들
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1 // '미션여부' 셀이 하나 있는 섹션
        } else {
            return 4 // '반복요일', '메모', '소리 설정', '다시 알림' 셀이 있는 섹션
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        // '미션여부' 셀 구성
        if indexPath.section == 0 {
            cell.textLabel?.text = "미션여부"
            
            let switchView = UISwitch()
            switchView.isOn = isMissionEnabled
            switchView.addTarget(self, action: #selector(missionSwitchValueChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = "반복요일"
                let detailLabel = UILabel()
                detailLabel.text = selectedDaysText()
                detailLabel.textColor = .gray
                detailLabel.sizeToFit()
                
                let accessory = UIView(frame: CGRect(x: 0, y: 0, width: detailLabel.frame.width + 20, height: detailLabel.frame.height))
                accessory.addSubview(detailLabel)
                
                detailLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview()
                    make.centerY.equalToSuperview()
                }
                
                let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
                arrowImageView.tintColor = .gray
                accessory.addSubview(arrowImageView)
                
                arrowImageView.snp.makeConstraints { make in
                    make.left.equalTo(detailLabel.snp.right).offset(5)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview()
                }
                
                cell.accessoryView = accessory
            } else if indexPath.row == 1 {
                // "메모" 셀 구성이 여기에 들어갑니다.
                let label = UILabel()
                label.text = "메모"
                cell.contentView.addSubview(label)
                
                let textField = UITextField()
                textField.tag = 100
                textField.placeholder = "메모 입력"
                textField.textAlignment = .right
                textField.clearButtonMode = .whileEditing
                cell.contentView.addSubview(textField)
                
                label.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(15)
                    make.centerY.equalToSuperview()
                    make.width.equalTo(50)
                }
                
                textField.snp.makeConstraints { make in
                    make.left.equalTo(label.snp.right).offset(10)
                    make.centerY.equalToSuperview()
                    make.right.equalToSuperview().offset(-15)
                    make.height.equalTo(30)
                }
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "소리 설정"
            } else if indexPath.section == 1 && indexPath.row == 3 {
                cell.textLabel?.text = "다시 알림"
                
                let switchView = UISwitch()
                switchView.isOn = isReminderEnabled
                switchView.addTarget(self, action: #selector(reminderSwitchValueChanged(_:)), for: .valueChanged)
                cell.accessoryView = switchView
            }
        }
        return cell
    }
    
    private func selectedDaysText() -> String {
        switch selectedDays.count {
        case 0:
            return "선택 안 함"
        case 1:
            return "\(selectedDays[0])요일마다"
        default:
            let lastDay = selectedDays.removeLast()
            let daysText = selectedDays.joined(separator: ", ")
            selectedDays.append(lastDay)
            return "\(daysText) 및 \(lastDay)"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 섹션에 따른 액션 처리 추가
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                repDayButtonTapped()
            } else if indexPath.row == 2 {
                soundSettingButtonTapped()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 50
        }
        return 0
    }
}
