//
//  SetAlarmVC.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/13/24.
//

import UIKit
import SnapKit

class SetAlarmVC: UIViewController {
    
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
        
        self.title = "알람 추가"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        // 제스처가 테이블뷰 셀 선택에 영향을 주지 않도록 설정
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        setupDayButton()
        setupSoundSettingButton()
        setupLabels()
        setupPickerView()
        setupTableView()
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
        
        // SnapKit을 사용하여 label의 위치와 크기를 설정합니다.
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200) // 화면 하단으로부터 100pt 위에 위치하도록 설정
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        // SnapKit을 사용하여 numberLabel의 위치와 크기를 설정합니다.
        numberLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(label.snp.top).offset(-20) // label 위로 20pt 떨어진 위치에 설정
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
        tableView.backgroundColor = .gray
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = UIColor.black.cgColor // 테두리 색상을 설정합니다.
        tableView.layer.borderWidth = 0.7 // 테두리 두께를 설정합니다.
        tableView.isScrollEnabled = false
        view.addSubview(tableView)
        
        // SnapKit을 사용하여 tableView의 위치와 크기를 설정
        tableView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pickerView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(180)
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func repDayButtonTapped() {
        let nextVC = SetDayVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func soundSettingButtonTapped() {
        let nextVC = SetSoundVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        print("알람이 저장되었습니다.")
        // 알람을 저장하는 로직
        self.dismiss(animated: true, completion: nil)
    }
}

extension SetAlarmVC: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return amPm.count
        } else if component == 1 {
            return hours.count
        } else {
            return minutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            // 오전/오후 선택 시
            label.text = amPm[row]
        } else if component == 1 {
            // 시간 선택 시
            numberLabel.text = hours[row]
        } else {
            // 분 선택 시
            // 여기에서 '60'을 제거해야 합니다. 'minutes' 배열은 0부터 59까지 있어야 합니다.
            numberLabel.text = minutes[row]
        }
    }
    
    
    // pickerView에서 보여주고 싶은 아이템의 제목
    // 각각의 component 마다 다른 값을 갖게 한다.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return amPm[row]
        } else if component == 1 {
            return hours[row]
        } else {
            return minutes[row]
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
}

extension SetAlarmVC: UIPickerViewDelegate {
    
}

extension SetAlarmVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // '반복요일'과 '소리 설정' 두 개의 셀
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
            // "메모" 레이블 추가
            let label = UILabel()
            label.text = "메모"
            cell.contentView.addSubview(label)
            
            // 텍스트 필드 추가
            let textField = UITextField()
            textField.placeholder = "메모 입력"
            textField.textAlignment = .right // 오른쪽 정렬
            textField.clearButtonMode = .whileEditing
            cell.contentView.addSubview(textField)
            
            // SnapKit을 사용하여 레이블과 텍스트 필드의 위치와 크기 설정
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
            
            return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            if indexPath.row == 0 {
                cell.textLabel?.text = "반복요일"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "소리 설정"
            } else {
                cell.textLabel?.text = "다시 알림"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            repDayButtonTapped()
        } else if indexPath.row == 2 {
            soundSettingButtonTapped()
        }
    }
}
