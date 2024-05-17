//
//  AlarmTableViewCell.swift
//  WakeUpNow
//
//  Created by 한철희 on 5/14/24.
//

import UIKit
import SnapKit

class AlarmTableViewCell: UITableViewCell {
    
    static let identifier = "AlarmTableViewCell"
    
    private let meridiemLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 45, weight: .light)
        return label
    }()
    
    private let alarmSwitch: UISwitch = {
        let switchControl = UISwitch()
        // 스위치 설정
        return switchControl
    }()
    
    private let memoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16) // 메모 텍스트의 크기는 조정 가능
        label.textColor = .gray // 메모 텍스트의 색상은 조정 가능
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(meridiemLabel)
        addSubview(timeLabel)
        addSubview(alarmSwitch)
        addSubview(memoLabel)
        
        // SnapKit을 사용한 레이아웃 설정
        meridiemLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20) // 왼쪽 여백을 0으로 설정
            make.centerY.equalToSuperview().offset(0)
            make.width.equalToSuperview().multipliedBy(0.1)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(meridiemLabel.snp.right).offset(-7)
            make.centerY.equalToSuperview().offset(-10)
            make.right.lessThanOrEqualTo(alarmSwitch.snp.left).offset(-10)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(meridiemLabel.snp.bottom).offset(5) // meridiemLabel 바로 아래에 위치
            make.left.equalToSuperview().offset(20) // 왼쪽 여백 설정
            make.right.equalToSuperview().offset(-20) // 오른쪽 여백 설정
        }
    }
    
    // 셀의 데이터를 설정하는 메서드
    func configure(with alarm: Alarm) {
        meridiemLabel.text = alarm.amPm
        timeLabel.text = alarm.formattedTime
        alarmSwitch.isOn = alarm.isReminderEnabled
        memoLabel.text = alarm.memo
    }
}



